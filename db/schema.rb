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

ActiveRecord::Schema.define(version: 20151030174626) do

  create_table "acupunctures", force: true do |t|
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.integer  "clinical_history_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "findid"
  end

  create_table "acupunture_points", force: true do |t|
    t.string   "x_axis"
    t.string   "y_axis"
    t.string   "name"
    t.text     "note"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "findid"
    t.integer  "acupuncture_id"
  end

  create_table "admin_in_organizations", force: true do |t|
    t.integer  "organization_id"
    t.integer  "password"
    t.string   "email"
    t.string   "user_name"
    t.boolean  "super_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", force: true do |t|
    t.string   "solictude"
    t.boolean  "accepted"
    t.datetime "dateandour"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assistant_permissionings", force: true do |t|
    t.integer  "office_assistant_assigned_doctor_id"
    t.boolean  "create_info_for_patient",             default: false
    t.boolean  "create_patient",                      default: true
    t.boolean  "update_patient",                      default: true
    t.boolean  "update_doctor",                       default: false
    t.boolean  "create_cite",                         default: true
    t.boolean  "assign_patient",                      default: true
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

  create_table "clinical_histories", force: true do |t|
    t.integer  "user_id"
    t.integer  "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "interview"
    t.text     "diagnostic"
    t.text     "suffering"
    t.text     "diagnostic_aux"
    t.text     "terapeutic_use"
    t.integer  "doctor_id"
    t.text     "note_pathology"
    t.text     "note_no_pathology"
    t.text     "note_family"
    t.text     "habitus_exterior"
    t.text     "mental_symptoms"
    t.text     "climatic_symptoms"
    t.text     "sweting"
    t.text     "appetite"
    t.text     "thirst"
    t.text     "desires_food_or_food_refusal"
    t.text     "sleep"
    t.text     "sexuality"
    t.text     "skin_and_appendages"
    t.text     "musculoskeletal_apparatus"
    t.text     "endocrine_system"
    t.text     "hematopoietic_system"
    t.text     "digestive_system"
    t.text     "genitourinary_system"
    t.text     "nervous_system"
    t.text     "cardiovascular_system"
  end

  create_table "clinical_history_to_diagnostics", force: true do |t|
    t.integer  "diagnostic_id"
    t.integer  "clinical_history_id"
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

  create_table "dental_notes", force: true do |t|
    t.integer  "dental_record_id"
    t.text     "note"
    t.text     "new_treatment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
  end

  create_table "dental_records", force: true do |t|
    t.integer  "user_id"
    t.integer  "clinical_history_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
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

  create_table "familial_diseases", force: true do |t|
    t.string   "name"
    t.integer  "clinical_history_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pathology"
    t.string   "genealogy"
  end

  create_table "hospitals", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "salt"
    t.integer  "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secure_code"
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

  create_table "locations", force: true do |t|
    t.string   "ip_address"
    t.float    "latitude"
    t.float    "longitude"
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
    t.string   "seller_code"
    t.boolean  "can_acces_admin", default: true
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

  create_table "no_pathological_antecedents", force: true do |t|
    t.string   "name"
    t.integer  "clinical_history_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "evaluation"
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
    t.integer  "clinical_history_id"
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

  create_table "office_assistant_assigned_doctors", force: true do |t|
    t.integer  "office_assistant_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "office_assistants", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.string   "phone"
    t.integer  "organization_id"
    t.integer  "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.integer  "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pathological_antecedents", force: true do |t|
    t.string   "name"
    t.integer  "clinical_history_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pathology"
  end

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.integer  "payment_global"
    t.integer  "bank_commission"
    t.integer  "final_comission"
    t.date     "init"
    t.date     "expire"
    t.boolean  "comissionpay"
    t.string   "seller_code"
    t.string   "method"
    t.string   "token_pay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phisical_explorations", force: true do |t|
    t.string   "body_part"
    t.text     "notes"
    t.integer  "clinical_history_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "tooths", force: true do |t|
    t.integer  "number"
    t.boolean  "top"
    t.boolean  "bottom"
    t.boolean  "left"
    t.boolean  "right"
    t.integer  "dental_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "center"
    t.string   "problem"
    t.text     "note"
    t.string   "class_action_top"
    t.string   "class_action_bottom"
    t.string   "class_action_left"
    t.string   "class_action_right"
    t.string   "class_action_center"
  end

  create_table "user_activities", force: true do |t|
    t.string   "activity"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_hospitals", force: true do |t|
    t.integer  "user_id"
    t.integer  "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_registers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cadre_card"
    t.string   "password"
    t.integer  "steap_proces"
    t.string   "sex"
    t.boolean  "terms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.date     "register"
    t.string   "confirmed_token"
    t.boolean  "confirmed",                   default: false
    t.text     "description"
    t.string   "role"
    t.text     "resume"
    t.datetime "last_loggin"
    t.boolean  "admin",                       default: false
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "sex"
    t.boolean  "terms"
    t.date     "date_of_birth"
    t.string   "advanced_key"
    t.string   "college"
    t.string   "cadre_card"
    t.text     "street_addres"
    t.boolean  "payment_method",              default: false
    t.string   "cupon"
    t.date     "validity"
    t.text     "specialism"
    t.boolean  "suspend",                     default: false
    t.string   "left_logo"
    t.string   "right_logo"
    t.string   "ethnic_group"
    t.string   "nationality"
    t.string   "marital_status"
    t.string   "occupation"
    t.string   "birthplace"
    t.string   "place_of_residence"
    t.text     "home"
    t.string   "person_in_charge"
    t.string   "religion"
    t.string   "sexual_preference"
    t.integer  "number_of_sexual_partners"
    t.string   "phone"
    t.string   "blood_type"
    t.boolean  "view_doctor_content",         default: true
    t.boolean  "dental_clinical_history",     default: false
    t.boolean  "dental_module",               default: false
    t.boolean  "homeopatic_clinical_history", default: false
    t.boolean  "acupulture_clinical_history", default: false
    t.boolean  "acupulture_module",           default: false
    t.boolean  "normative_clinical_history",  default: true
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
    t.integer  "clinical_history_id"
  end

end
