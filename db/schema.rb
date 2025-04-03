# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_04_03_122537) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "banners", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_banners_on_event_id"
  end

  create_table "blogs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_blogs_on_event_id"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "title"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_categories_on_event_id"
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.string "message"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_contacts_on_event_id"
  end

  create_table "courses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "is_active", default: true
    t.string "duration"
    t.bigint "category_id"
    t.bigint "event_id"
    t.boolean "has_download_certificate", default: false
    t.boolean "is_paid", default: false
    t.float "total_marks", default: 0.0
    t.float "passing_points", default: 0.0
    t.boolean "has_pass_fail_page", default: false
    t.integer "max_attempts", default: 0
    t.datetime "valid_from"
    t.datetime "valid_upto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teacher_id"
    t.string "title"
    t.bigint "ticket_id"
    t.index ["category_id"], name: "index_courses_on_category_id"
    t.index ["event_id"], name: "index_courses_on_event_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
    t.index ["ticket_id"], name: "index_courses_on_ticket_id"
  end

  create_table "discounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "code"
    t.boolean "is_active"
    t.boolean "is_percentage"
    t.string "discount_amount"
    t.float "min_discount"
    t.float "max_discount"
    t.datetime "valid_from"
    t.datetime "valid_still"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_discounts_on_event_id"
  end

  create_table "email_contents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email_type"
    t.string "subject"
    t.text "content"
    t.bigint "role_id"
    t.bigint "event_id"
    t.string "from_email"
    t.text "cc_email"
    t.boolean "has_attachment"
    t.text "attachment"
    t.datetime "schedule_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_email_contents_on_event_id"
    t.index ["role_id"], name: "index_email_contents_on_role_id"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "slug"
    t.text "address"
    t.string "email"
    t.string "phone"
    t.string "time_zone"
    t.text "custom_css"
    t.text "custom_js"
    t.text "terms_and_conditions"
    t.text "about_text"
    t.string "publishable_key"
    t.string "secret_key"
    t.text "footer_text"
    t.string "gallery_text"
    t.text "page_content"
    t.boolean "hide_about_page"
    t.boolean "hide_category"
    t.boolean "hide_courses"
    t.boolean "hide_gallery"
    t.boolean "hide_info"
    t.boolean "hide_teacher_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
  end

  create_table "favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "favoritable_type", null: false
    t.bigint "favoritable_id", null: false
    t.string "favoritor_type", null: false
    t.bigint "favoritor_id", null: false
    t.string "scope", default: "favorite", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favoritable_id", "favoritable_type"], name: "fk_favoritables"
    t.index ["favoritable_type", "favoritable_id", "favoritor_type", "favoritor_id", "scope"], name: "uniq_favorites_and_favoritables", unique: true, length: { favoritable_type: 191, favoritor_type: 191, scope: 100 }
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable"
    t.index ["favoritor_id", "favoritor_type"], name: "fk_favorites"
    t.index ["favoritor_type", "favoritor_id"], name: "index_favorites_on_favoritor"
  end

  create_table "form_field_choices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "sequence"
    t.string "caption"
    t.boolean "is_active", default: true
    t.boolean "specific_field_if_other", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.bigint "form_section_field_id"
    t.index ["form_section_field_id"], name: "index_form_field_choices_on_form_section_field_id"
  end

  create_table "form_section_fields", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "caption"
    t.string "placeholder"
    t.text "field_hint"
    t.string "field_type"
    t.string "data_field"
    t.string "value"
    t.integer "sequence"
    t.boolean "is_required", default: false
    t.boolean "is_active", default: true
    t.boolean "is_single_column", default: false
    t.bigint "form_id"
    t.bigint "form_section_id"
    t.boolean "file_upload_filed", default: false
    t.string "file_upload_type", default: "image/jpeg,image/jpg,image/png,application/pdf,application/msword,application/mspowerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/vnd.openxmlformats-officedocument.wordprocessingml.document,audio/*,video/*"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_section_fields_on_form_id"
    t.index ["form_section_id"], name: "index_form_section_fields_on_form_section_id"
  end

  create_table "form_sections", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "caption"
    t.text "section_hint"
    t.bigint "form_id"
    t.integer "sequence"
    t.boolean "is_active", default: true
    t.boolean "is_payment_section", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_sections_on_form_id"
  end

  create_table "forms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "caption"
    t.text "description"
    t.bigint "event_id"
    t.boolean "is_active", default: true
    t.string "registration_successful_message", default: "Registered Successfully. A confirmation mail is sent to you. Thank you!"
    t.string "registration_updated_successful_message", default: "Profile Updated Successfully"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["event_id"], name: "index_forms_on_event_id"
    t.index ["role_id"], name: "index_forms_on_role_id"
  end

  create_table "quiz_attempt_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quiz_topic_id", null: false
    t.text "question"
    t.text "answer"
    t.float "is_right"
    t.float "is_wrong"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_topic_id"], name: "index_quiz_attempt_results_on_quiz_topic_id"
    t.index ["user_id"], name: "index_quiz_attempt_results_on_user_id"
  end

  create_table "quiz_attempts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "marks_gained"
    t.bigint "quiz_attempt_result_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_attempt_result_id"], name: "index_quiz_attempts_on_quiz_attempt_result_id"
    t.index ["user_id"], name: "index_quiz_attempts_on_user_id"
  end

  create_table "quiz_question_options", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "title"
    t.boolean "is_right"
    t.boolean "is_last_option"
    t.bigint "quiz_question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_question_id"], name: "index_quiz_question_options_on_quiz_question_id"
  end

  create_table "quiz_questions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "sequence"
    t.text "title"
    t.string "question_type"
    t.bigint "quiz_topic_id"
    t.text "wrong_answer_explanation"
    t.boolean "is_required", default: false
    t.text "correct_answer_explanation"
    t.float "marks"
    t.float "negative_marks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_topic_id"], name: "index_quiz_questions_on_quiz_topic_id"
  end

  create_table "quiz_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "is_pass"
    t.bigint "quiz_attempt_id", null: false
    t.float "points"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_quiz_results_on_course_id"
    t.index ["quiz_attempt_id"], name: "index_quiz_results_on_quiz_attempt_id"
    t.index ["user_id"], name: "index_quiz_results_on_user_id"
  end

  create_table "quiz_topics", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "sequence"
    t.boolean "practise_quiz", default: false
    t.bigint "course_id"
    t.bigint "catgory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catgory_id"], name: "index_quiz_topics_on_catgory_id"
    t.index ["course_id"], name: "index_quiz_topics_on_course_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.bigint "event_id", null: false
    t.boolean "is_active"
    t.string "currency"
    t.boolean "is_donation"
    t.datetime "valid_from"
    t.datetime "valid_still"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "price_cents", default: 0, null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "user_courses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.boolean "completed"
    t.string "feedback"
    t.string "certificate_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "user_notes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "subject"
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_notes_on_course_id"
    t.index ["event_id"], name: "index_user_notes_on_event_id"
    t.index ["user_id"], name: "index_user_notes_on_user_id"
  end

  create_table "user_tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "discount_code"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.bigint "ticket_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_tickets_on_course_id"
    t.index ["event_id"], name: "index_user_tickets_on_event_id"
    t.index ["ticket_id"], name: "index_user_tickets_on_ticket_id"
    t.index ["user_id"], name: "index_user_tickets_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salutation"
    t.text "position"
    t.text "organization"
    t.string "address"
    t.string "city"
    t.string "mobile"
    t.string "online_status", default: "offline"
    t.string "locale", default: "en"
    t.string "otp"
    t.string "avatar"
    t.string "authentication_token"
    t.text "custom_fields"
    t.string "current_event_id"
    t.string "f1"
    t.string "f2"
    t.string "f3"
    t.string "f4"
    t.string "f5"
    t.string "f6"
    t.string "f7"
    t.string "f8"
    t.string "f9"
    t.string "f10"
    t.string "f11"
    t.string "f12"
    t.string "f13"
    t.string "f14"
    t.string "f15"
    t.bigint "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "votes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "banners", "events"
  add_foreign_key "blogs", "events"
  add_foreign_key "blogs", "users"
  add_foreign_key "categories", "events", on_delete: :cascade
  add_foreign_key "contacts", "events"
  add_foreign_key "courses", "events", on_delete: :cascade
  add_foreign_key "courses", "tickets", on_delete: :cascade
  add_foreign_key "courses", "users", column: "teacher_id"
  add_foreign_key "discounts", "events"
  add_foreign_key "email_contents", "events"
  add_foreign_key "form_field_choices", "form_section_fields"
  add_foreign_key "form_section_fields", "form_sections"
  add_foreign_key "form_section_fields", "forms"
  add_foreign_key "form_sections", "forms"
  add_foreign_key "forms", "events"
  add_foreign_key "forms", "roles", on_delete: :nullify
  add_foreign_key "quiz_attempt_results", "quiz_topics"
  add_foreign_key "quiz_attempt_results", "users"
  add_foreign_key "quiz_attempts", "quiz_attempt_results"
  add_foreign_key "quiz_attempts", "users"
  add_foreign_key "quiz_question_options", "quiz_questions"
  add_foreign_key "quiz_questions", "quiz_topics", on_delete: :cascade
  add_foreign_key "quiz_results", "courses"
  add_foreign_key "quiz_results", "quiz_attempts"
  add_foreign_key "quiz_results", "users"
  add_foreign_key "quiz_topics", "categories", column: "catgory_id"
  add_foreign_key "quiz_topics", "courses"
  add_foreign_key "tickets", "events"
  add_foreign_key "tickets", "users", on_delete: :cascade
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
  add_foreign_key "user_notes", "courses"
  add_foreign_key "user_notes", "events"
  add_foreign_key "user_notes", "users"
  add_foreign_key "user_tickets", "courses"
  add_foreign_key "user_tickets", "events"
  add_foreign_key "user_tickets", "tickets"
  add_foreign_key "user_tickets", "users"
  add_foreign_key "users", "roles", on_delete: :nullify
end
