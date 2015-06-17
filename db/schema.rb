# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150617100424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "foo", id: false, force: :cascade do |t|
    t.integer "name"
    t.integer "test"
  end

  create_table "general_notes", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.text     "title"
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "title"
    t.text     "description"
    t.date     "start"
    t.date     "end"
    t.integer  "parent_id"
    t.integer  "lft",                        null: false
    t.integer  "rgt",                        null: false
    t.integer  "depth",          default: 0, null: false
    t.integer  "children_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "completed"
  end

  add_index "goals", ["lft"], name: "index_goals_on_lft", using: :btree
  add_index "goals", ["parent_id"], name: "index_goals_on_parent_id", using: :btree
  add_index "goals", ["rgt"], name: "index_goals_on_rgt", using: :btree
  add_index "goals", ["student_id"], name: "index_goals_on_student_id", using: :btree

  create_table "lesson_plan_items", force: :cascade do |t|
    t.time     "start"
    t.time     "end"
    t.string   "subject"
    t.string   "topic"
    t.text     "goals"
    t.text     "teaching_method"
    t.text     "teaching_aids"
    t.integer  "lesson_plan_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "type",            default: "RegularLessonPlanItem"
    t.json     "elc_data"
    t.text     "theme"
  end

  add_index "lesson_plan_items", ["lesson_plan_id"], name: "index_lesson_plan_items_on_lesson_plan_id", using: :btree

  create_table "lesson_plans", force: :cascade do |t|
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lesson_plans", ["user_id"], name: "index_lesson_plans_on_user_id", using: :btree

  create_table "long_term_goals", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "name"
    t.text     "description"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "long_term_goals", ["student_id"], name: "index_long_term_goals_on_student_id", using: :btree

  create_table "short_term_goals", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "long_term_goal_id"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "short_term_goals", ["long_term_goal_id"], name: "index_short_term_goals_on_long_term_goal_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "notes"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "goals", "students"
  add_foreign_key "lesson_plan_items", "lesson_plans"
  add_foreign_key "lesson_plans", "users"
  add_foreign_key "long_term_goals", "students"
  add_foreign_key "short_term_goals", "long_term_goals"
end
