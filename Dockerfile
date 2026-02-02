
# Stage 1: Build the application

FROM ruby:3.2.0 

WORKDIR /var/www/html

RUN gem install bundler -v 2.5.23

COPY . /var/www/html/

RUN bundle install

# RUN rails s

EXPOSE 8000

CMD ["rails", "s", "-b", "0.0.0.0"]
