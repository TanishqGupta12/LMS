# frozen_string_literal: true

# Idempotent seeds — safe to run multiple times (e.g. Docker boot).
# Override default passwords: SEED_USER_PASSWORD=your_secret bin/rails db:seed

seed_password = ENV.fetch("SEED_USER_PASSWORD", "password123")

roles = %w[SuperAdmin Admin Teacher Student].map do |name|
  Role.find_or_create_by!(name: name) { |r| r.active = true }
end
roles_by_name = roles.index_by(&:name)

event = Event.find_or_initialize_by(slug: "demo-lms")
event.assign_attributes(
  name: "Demo LMS",
  description: "Sample event for local development and demos.",
  email: "demo@example.com",
  phone: "+1-555-0100",
  time_zone: "UTC",
  address: "123 Learning Lane"
)
event.save!

category = event.categories.find_or_create_by!(content: "Getting started")

course = Course.find_or_initialize_by(event_id: event.id, category_id: category.id)
course.assign_attributes(
  is_active: true,
  duration: "2 hours",
  is_paid: false,
  total_marks: 10.0,
  passing_points: 5.0
)
course.save!

def upsert_user!(email:, username:, first_name:, last_name:, role:, event_id:, password:)
  user = User.find_or_initialize_by(email: email)
  user.assign_attributes(
    username: username,
    first_name: first_name,
    last_name: last_name,
    role: role,
    current_event_id: event_id.to_s
  )
  if user.new_record?
    user.password = password
    user.password_confirmation = password
  end
  user.save!
  user
end

upsert_user!(
  email: "admin@example.com",
  username: "superadmin",
  first_name: "Super",
  last_name: "Admin",
  role: roles_by_name["SuperAdmin"],
  event_id: event.id,
  password: seed_password
)

upsert_user!(
  email: "manager@example.com",
  username: "manager",
  first_name: "Event",
  last_name: "Manager",
  role: roles_by_name["Admin"],
  event_id: event.id,
  password: seed_password
)

upsert_user!(
  email: "teacher@example.com",
  username: "teacher",
  first_name: "Demo",
  last_name: "Teacher",
  role: roles_by_name["Teacher"],
  event_id: event.id,
  password: seed_password
)

upsert_user!(
  email: "student@example.com",
  username: "student",
  first_name: "Demo",
  last_name: "Student",
  role: roles_by_name["Student"],
  event_id: event.id,
  password: seed_password
)

puts "Seeds finished: event=#{event.slug}, demo users created (password from SEED_USER_PASSWORD or default)."
