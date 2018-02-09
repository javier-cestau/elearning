# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180208124955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", id: :serial, force: :cascade do |t|
    t.text "description"
    t.integer "is_correct"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "choises", id: :serial, force: :cascade do |t|
    t.text "description"
    t.integer "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_choises_on_survey_id"
  end

  create_table "comment_courses", id: :serial, force: :cascade do |t|
    t.text "body"
    t.integer "course_id"
    t.integer "user_id"
    t.integer "prv_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_comment_courses_on_course_id"
    t.index ["user_id"], name: "index_comment_courses_on_user_id"
  end

  create_table "comment_sections", id: :serial, force: :cascade do |t|
    t.text "body"
    t.integer "section_id"
    t.integer "user_id"
    t.integer "prv_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_comment_sections_on_section_id"
    t.index ["user_id"], name: "index_comment_sections_on_user_id"
  end

  create_table "course_has_departments", id: :serial, force: :cascade do |t|
    t.integer "department_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_course_has_departments_on_course_id"
    t.index ["department_id"], name: "index_course_has_departments_on_department_id"
  end

  create_table "course_has_private_users", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_has_private_users_on_course_id"
    t.index ["user_id"], name: "index_course_has_private_users_on_user_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "scoping"
    t.integer "prelation"
    t.text "description"
    t.integer "active"
    t.string "cover_file_name"
    t.string "cover_content_type"
    t.integer "cover_file_size"
    t.datetime "cover_updated_at"
    t.date "start_date"
    t.date "deadline_course"
    t.date "deadline_inscription"
    t.date "day_counter_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_courses_on_category_id"
    t.index ["name"], name: "index_courses_on_name"
  end

  create_table "departments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "do_courses", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
    t.date "start_date"
    t.date "finished_at"
    t.integer "enroll"
    t.integer "failed", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_do_courses_on_course_id"
    t.index ["user_id"], name: "index_do_courses_on_user_id"
  end

  create_table "do_recomendations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_do_recomendations_on_course_id"
    t.index ["user_id"], name: "index_do_recomendations_on_user_id"
  end

  create_table "do_templates", id: :serial, force: :cascade do |t|
    t.integer "template_id"
    t.integer "user_id"
    t.integer "survey_id"
    t.integer "response_id"
    t.integer "sequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["response_id"], name: "index_do_templates_on_response_id"
    t.index ["survey_id"], name: "index_do_templates_on_survey_id"
    t.index ["template_id"], name: "index_do_templates_on_template_id"
    t.index ["user_id"], name: "index_do_templates_on_user_id"
  end

  create_table "do_tests", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "test_id"
    t.integer "do_course_id"
    t.integer "duration", default: 0
    t.integer "grade", default: 0
    t.integer "active", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["do_course_id"], name: "index_do_tests_on_do_course_id"
    t.index ["test_id"], name: "index_do_tests_on_test_id"
    t.index ["user_id"], name: "index_do_tests_on_user_id"
  end

  create_table "favorites", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_favorites_on_course_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "has_answers", id: :serial, force: :cascade do |t|
    t.integer "answer_id"
    t.integer "do_test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_has_answers_on_answer_id"
    t.index ["do_test_id"], name: "index_has_answers_on_do_test_id"
  end

  create_table "has_choises", id: :serial, force: :cascade do |t|
    t.integer "choise_id"
    t.integer "response_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choise_id"], name: "index_has_choises_on_choise_id"
    t.index ["response_id"], name: "index_has_choises_on_response_id"
  end

  create_table "has_favorites", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_has_favorites_on_course_id"
    t.index ["user_id"], name: "index_has_favorites_on_user_id"
  end

  create_table "has_tags", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_has_tags_on_course_id"
    t.index ["tag_id"], name: "index_has_tags_on_tag_id"
  end

  create_table "has_templates", id: :serial, force: :cascade do |t|
    t.integer "template_id"
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_has_templates_on_department_id"
    t.index ["template_id"], name: "index_has_templates_on_template_id"
  end

  create_table "multimedia_courses", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.string "video_file_name"
    t.string "video_content_type"
    t.integer "video_file_size"
    t.datetime "video_updated_at"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["course_id"], name: "index_multimedia_courses_on_course_id"
  end

  create_table "multimedia_sections", id: :serial, force: :cascade do |t|
    t.integer "section_id"
    t.string "video_file_name"
    t.string "video_content_type"
    t.integer "video_file_size"
    t.datetime "video_updated_at"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["section_id"], name: "index_multimedia_sections_on_section_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "read", default: 0
    t.integer "user_id"
    t.datetime "date"
    t.string "url"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "prelations", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.integer "prelated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_prelations_on_course_id"
  end

  create_table "profile_infos", force: :cascade do |t|
    t.bigint "profile_id"
    t.string "question"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_infos_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.integer "sequence"
    t.text "description"
    t.integer "test_id"
    t.integer "type_question_id"
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
    t.index ["type_question_id"], name: "index_questions_on_type_question_id"
  end

  create_table "responses", id: :serial, force: :cascade do |t|
    t.text "description"
  end

  create_table "section_files", id: :serial, force: :cascade do |t|
    t.integer "section_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.index ["section_id"], name: "index_section_files_on_section_id"
  end

  create_table "sections", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "prv_section"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "surveys", id: :serial, force: :cascade do |t|
    t.string "description"
    t.integer "sequence"
    t.integer "type_survey_id"
    t.integer "template_id"
    t.integer "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_surveys_on_template_id"
    t.index ["type_survey_id"], name: "index_surveys_on_type_survey_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "templates", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", id: :serial, force: :cascade do |t|
    t.text "description"
    t.integer "attemps_limits", default: 0
    t.integer "time_limit", default: 0
    t.integer "min_grade"
    t.date "start_date"
    t.date "deadline"
    t.integer "required"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "section_id"
    t.boolean "auto"
    t.index ["deleted_at"], name: "index_tests_on_deleted_at"
    t.index ["section_id"], name: "index_tests_on_section_id"
  end

  create_table "type_questions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "sequence"
  end

  create_table "type_surveys", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "sequence"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.integer "privilege"
    t.string "email"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.date "reset_password_sent_at"
    t.date "remember_created_at"
    t.integer "sign_in_count"
    t.date "current_sign_in_at"
    t.date "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "uid"
    t.string "provider"
    t.string "position"
    t.string "management"
    t.string "name"
    t.integer "state", default: 1
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "choises", "surveys"
  add_foreign_key "comment_courses", "courses"
  add_foreign_key "comment_courses", "users"
  add_foreign_key "comment_sections", "sections"
  add_foreign_key "comment_sections", "users"
  add_foreign_key "course_has_departments", "courses"
  add_foreign_key "course_has_departments", "departments"
  add_foreign_key "course_has_private_users", "courses"
  add_foreign_key "course_has_private_users", "users"
  add_foreign_key "courses", "categories"
  add_foreign_key "do_courses", "courses"
  add_foreign_key "do_courses", "users"
  add_foreign_key "do_recomendations", "courses"
  add_foreign_key "do_recomendations", "users"
  add_foreign_key "do_templates", "responses"
  add_foreign_key "do_templates", "surveys"
  add_foreign_key "do_templates", "templates"
  add_foreign_key "do_templates", "users"
  add_foreign_key "do_tests", "do_courses"
  add_foreign_key "do_tests", "tests"
  add_foreign_key "do_tests", "users"
  add_foreign_key "favorites", "courses"
  add_foreign_key "favorites", "users"
  add_foreign_key "has_answers", "answers"
  add_foreign_key "has_answers", "do_tests"
  add_foreign_key "has_choises", "choises"
  add_foreign_key "has_choises", "responses"
  add_foreign_key "has_favorites", "courses"
  add_foreign_key "has_favorites", "users"
  add_foreign_key "has_tags", "courses"
  add_foreign_key "has_tags", "tags"
  add_foreign_key "has_templates", "departments"
  add_foreign_key "has_templates", "templates"
  add_foreign_key "multimedia_courses", "courses"
  add_foreign_key "multimedia_sections", "sections"
  add_foreign_key "notifications", "users"
  add_foreign_key "prelations", "courses"
  add_foreign_key "profile_infos", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "tests"
  add_foreign_key "questions", "type_questions"
  add_foreign_key "section_files", "sections"
  add_foreign_key "sections", "courses"
  add_foreign_key "surveys", "templates"
  add_foreign_key "surveys", "type_surveys"
  add_foreign_key "tests", "sections"
  add_foreign_key "users", "departments"
end
