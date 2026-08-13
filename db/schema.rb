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

ActiveRecord::Schema[8.1].define(version: 2026_08_13_060527) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "club_activities", force: :cascade do |t|
    t.date "activity_date"
    t.integer "club_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.string "image_url"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_club_activities_on_club_id"
  end

  create_table "club_activity_reports", force: :cascade do |t|
    t.date "activity_date"
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "learning_club_id", null: false
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["learning_club_id"], name: "index_club_activity_reports_on_learning_club_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.integer "current_members"
    t.text "description"
    t.string "leader_name"
    t.integer "max_members"
    t.string "name"
    t.string "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_clubs_on_user_id"
  end

  create_table "course_registrations", force: :cascade do |t|
    t.datetime "cancelled_at"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.string "discount_proof"
    t.integer "discount_status"
    t.integer "paid_amount"
    t.integer "refund_amount"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "waitlist_position"
    t.index ["course_id"], name: "index_course_registrations_on_course_id"
    t.index ["user_id"], name: "index_course_registrations_on_user_id"
  end

  create_table "course_reviews", force: :cascade do |t|
    t.text "contnt"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "rating"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["course_id"], name: "index_course_reviews_on_course_id"
    t.index ["user_id"], name: "index_course_reviews_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "instructor_name"
    t.integer "max_students"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["category_id"], name: "index_courses_on_category_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "fee"
    t.string "image_url"
    t.string "location"
    t.string "name"
    t.string "status"
    t.datetime "updated_at", null: false
  end

  create_table "facility_reservations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "end_time"
    t.integer "facility_id", null: false
    t.integer "headcount"
    t.string "purpose"
    t.date "reservation_date"
    t.string "start_time"
    t.string "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["facility_id"], name: "index_facility_reservations_on_facility_id"
    t.index ["user_id"], name: "index_facility_reservations_on_user_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.text "core_values", null: false
    t.datetime "created_at", null: false
    t.text "greeting_content", null: false
    t.string "greeting_title", null: false
    t.text "mission", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instructor_payrolls", force: :cascade do |t|
    t.integer "calculated_amount"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "instructor_profile_id", null: false
    t.integer "status"
    t.string "target_month"
    t.integer "teaching_hours"
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_instructor_payrolls_on_course_id"
    t.index ["instructor_profile_id"], name: "index_instructor_payrolls_on_instructor_profile_id"
  end

  create_table "instructor_profiles", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "specialty"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_instructor_profiles_on_user_id"
  end

  create_table "learning_clubs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_learning_clubs_on_user_id"
  end

  create_table "lesson_progresses", force: :cascade do |t|
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["lesson_id"], name: "index_lesson_progresses_on_lesson_id"
    t.index ["user_id", "lesson_id"], name: "index_lesson_progresses_on_user_id_and_lesson_id", unique: true
    t.index ["user_id"], name: "index_lesson_progresses_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "row_order"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "notices", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.boolean "is_pinned", default: false, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "view_count", default: 0, null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["course_id"], name: "index_registrations_on_course_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "bio"
    t.date "birth_date"
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email_address"
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "gender"
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "locked_at"
    t.string "name", default: "", null: false
    t.string "password_digest"
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "club_activities", "clubs"
  add_foreign_key "club_activity_reports", "learning_clubs"
  add_foreign_key "clubs", "users"
  add_foreign_key "course_registrations", "courses"
  add_foreign_key "course_registrations", "users"
  add_foreign_key "course_reviews", "courses"
  add_foreign_key "course_reviews", "users"
  add_foreign_key "courses", "categories"
  add_foreign_key "courses", "users"
  add_foreign_key "facility_reservations", "facilities"
  add_foreign_key "facility_reservations", "users"
  add_foreign_key "instructor_payrolls", "courses"
  add_foreign_key "instructor_payrolls", "instructor_profiles"
  add_foreign_key "instructor_profiles", "users"
  add_foreign_key "learning_clubs", "users"
  add_foreign_key "lesson_progresses", "lessons"
  add_foreign_key "lesson_progresses", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "registrations", "courses"
  add_foreign_key "registrations", "users"
  add_foreign_key "sessions", "users"
end
