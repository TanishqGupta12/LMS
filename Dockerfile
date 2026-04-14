# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.0
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

# Set env vars once in base so all stages inherit them
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    NODE_VERSION="20.x"

# ─── Build Stage ────────────────────────────────────────────────────────────
FROM base AS build

# Install build deps in one layer; clean up in the same RUN to minimize image size
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl ca-certificates gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
    apt-get install --no-install-recommends -y \
      nodejs \
      build-essential \
      pkg-config \
      default-libmysqlclient-dev && \
    npm install -g yarn@1.22.22 --prefer-offline && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Install gems — copied before app code so this layer is cached unless Gemfile changes
COPY Gemfile Gemfile.lock ./
RUN --mount=type=cache,id=bundle-cache,target=/usr/local/bundle/cache \
    bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Install JS deps — yarn.lock is more reliable than package-lock when yarn is the runner
COPY package.json yarn.lock ./
RUN --mount=type=cache,id=yarn-cache,target=/root/.yarn \
    yarn install --frozen-lockfile --prefer-offline

# Copy app source last so code changes don't invalidate gem/node caches above
COPY . .

# Precompile Ruby bootsnap cache, then assets
RUN bundle exec bootsnap precompile app/ lib/ && \
    SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# ─── Runtime Stage ──────────────────────────────────────────────────────────
FROM base AS runtime

# Only runtime libs needed — no build tools, no Node, no yarn
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libmariadb3 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copy only what the app needs at runtime
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Non-root user for security
RUN useradd --create-home --shell /bin/bash rails && \
    chown -R rails:rails db log storage tmp
USER rails:rails

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]