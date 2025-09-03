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

ActiveRecord::Schema[8.0].define(version: 2025_09_03_005633) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "aggregates", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.bigint "theme_id", null: false
    t.bigint "question_id", null: false
    t.decimal "avg_score", precision: 4, scale: 2
    t.integer "responses_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_aggregates_on_question_id"
    t.index ["survey_id"], name: "index_aggregates_on_survey_id"
    t.index ["theme_id"], name: "index_aggregates_on_theme_id"
  end

  create_table "delivery_logs", force: :cascade do |t|
    t.bigint "participation_id", null: false
    t.integer "channel"
    t.integer "status"
    t.string "provider_message_id"
    t.datetime "sent_at"
    t.text "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participation_id"], name: "index_delivery_logs_on_participation_id"
  end

  create_table "message_templates", force: :cascade do |t|
    t.integer "scope"
    t.string "subject"
    t.text "body"
    t.boolean "default"
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_message_templates_on_school_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.bigint "teacher_id", null: false
    t.string "token"
    t.integer "status"
    t.datetime "opened_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "last_seen_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_participations_on_survey_id"
    t.index ["teacher_id"], name: "index_participations_on_teacher_id"
  end

  create_table "question_responses", force: :cascade do |t|
    t.bigint "participation_id", null: false
    t.bigint "survey_id", null: false
    t.bigint "theme_id", null: false
    t.bigint "question_id", null: false
    t.integer "score"
    t.datetime "answered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participation_id"], name: "index_question_responses_on_participation_id"
    t.index ["question_id"], name: "index_question_responses_on_question_id"
    t.index ["survey_id"], name: "index_question_responses_on_survey_id"
    t.index ["theme_id"], name: "index_question_responses_on_theme_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "theme_id", null: false
    t.text "label"
    t.boolean "active"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id"], name: "index_questions_on_theme_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.integer "format"
    t.datetime "generated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_reports_on_survey_id"
  end

  create_table "school_directors", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "invited_at"
    t.string "invitation_token"
    t.datetime "invitation_accepted_at"
    t.index ["school_id"], name: "index_school_directors_on_school_id"
    t.index ["user_id"], name: "index_school_directors_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.string "slug"
    t.jsonb "settings_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_themes", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.bigint "theme_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_themes_on_survey_id"
    t.index ["theme_id"], name: "index_survey_themes_on_theme_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.integer "status"
    t.datetime "launched_at"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_surveys_on_school_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.boolean "archived"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  create_table "themes", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "aggregates", "questions"
  add_foreign_key "aggregates", "surveys"
  add_foreign_key "aggregates", "themes"
  add_foreign_key "delivery_logs", "participations"
  add_foreign_key "message_templates", "schools"
  add_foreign_key "participations", "surveys"
  add_foreign_key "participations", "teachers"
  add_foreign_key "question_responses", "participations"
  add_foreign_key "question_responses", "questions"
  add_foreign_key "question_responses", "surveys"
  add_foreign_key "question_responses", "themes"
  add_foreign_key "questions", "themes"
  add_foreign_key "reports", "surveys"
  add_foreign_key "school_directors", "schools"
  add_foreign_key "school_directors", "users"
  add_foreign_key "survey_themes", "surveys"
  add_foreign_key "survey_themes", "themes"
  add_foreign_key "surveys", "schools"
  add_foreign_key "teachers", "schools"
end
