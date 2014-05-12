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

ActiveRecord::Schema.define(version: 20140512182448) do

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
  end

  create_table "doctor_patients", force: true do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted_request", default: false
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

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.datetime "caduce"
    t.datetime "created_at"
    t.datetime "updated_at"
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
