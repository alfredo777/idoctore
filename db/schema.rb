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

ActiveRecord::Schema.define(version: 20140718210221) do

  create_table "appointments", force: true do |t|
    t.string   "solictude"
    t.boolean  "accepted"
    t.datetime "dateandour"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cite_doctors", force: true do |t|
    t.datetime "init_time"
    t.datetime "finish_time"
    t.text     "request"
    t.boolean  "confirmed_by_doctor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "doctor_id"
  end

  create_table "clinical_analyses", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "diagnostic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cupons", force: true do |t|
    t.string   "institution"
    t.string   "indentifier_random"
    t.boolean  "used"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "printing"
    t.integer  "manager_user_id"
    t.integer  "assigned"
    t.string   "email_corroborate"
    t.integer  "price"
  end

  create_table "delete_histories", force: true do |t|
    t.integer  "user_id"
    t.integer  "owner_id"
    t.text     "delete_content"
    t.string   "causes"
    t.text     "justify"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnostics", force: true do |t|
    t.integer  "user_id"
    t.text     "interrogation"
    t.text     "physical_examination"
    t.text     "diagnostic_or_clinical_problem"
    t.text     "list_of_laboratory_studies"
    t.text     "required_therapies"
    t.text     "suggested_treatments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_by"
    t.boolean  "chronic"
    t.boolean  "outstanding"
    t.boolean  "serious"
    t.boolean  "inconsequential"
    t.integer  "vital_signs"
    t.string   "qrcode"
  end

  create_table "diseases", force: true do |t|
    t.string   "name"
    t.string   "id_from_icd10"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctor_patients", force: true do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted_request", default: false
  end

  create_table "institutions", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "logo_string"
    t.text     "study_or_do"
    t.boolean  "recipe_appears"
    t.boolean  "appears_in_diagnostic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manager_users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identify"
    t.boolean  "seller"
  end

  create_table "medicines", force: true do |t|
    t.string   "name"
    t.string   "laboratoy"
    t.text     "indications"
    t.date     "init_date"
    t.date     "finish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_user_to_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.string   "converstion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cite_doctor_id"
    t.text     "message"
  end

  create_table "notes", force: true do |t|
    t.text     "content"
    t.integer  "last_analysis"
    t.integer  "last_signs"
    t.text     "new_treatment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "diagnostic_id"
    t.integer  "user_id"
  end

  create_table "notices", force: true do |t|
    t.integer  "user_id"
    t.integer  "receiver_id"
    t.string   "typex"
    t.integer  "typex_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked"
  end

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.datetime "caduce"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "single_files", force: true do |t|
    t.string   "name"
    t.string   "archive"
    t.string   "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.date     "register"
    t.string   "confirmed_token"
    t.boolean  "confirmed",       default: false
    t.text     "description"
    t.string   "role"
    t.text     "resume"
    t.datetime "last_loggin"
    t.boolean  "admin",           default: false
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "sex"
    t.boolean  "terms"
    t.date     "date_of_birth"
    t.string   "advanced_key"
    t.string   "college"
  end

  create_table "vital_signs", force: true do |t|
    t.integer  "weight"
    t.integer  "blood_pressure_up"
    t.integer  "blood_pressure_down"
    t.integer  "pulse"
    t.integer  "height"
    t.integer  "breathing"
    t.integer  "temperature"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_by"
  end

end
