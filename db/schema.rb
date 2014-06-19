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

ActiveRecord::Schema.define(version: 20140619051125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: true do |t|
    t.integer  "nc_question_id"
    t.integer  "value"
    t.text     "detailed_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artifact_answers", force: true do |t|
    t.integer  "audit_compliance_id"
    t.integer  "artifact_id"
    t.integer  "responsibility_id"
    t.date     "target_date"
    t.integer  "priority_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artifacts", force: true do |t|
    t.string   "name"
    t.integer  "compliance_library_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.string   "attachment_file"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "classified"
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree

  create_table "audit_auditees", force: true do |t|
    t.integer  "user_id"
    t.integer  "audit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audit_compliances", force: true do |t|
    t.integer  "compliance_library_id"
    t.integer  "audit_id"
    t.integer  "score_id"
    t.boolean  "is_answered",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audit_operational_weightages", force: true do |t|
    t.integer  "operational_area_id"
    t.integer  "audit_id"
    t.integer  "weightage"
    t.integer  "total_score"
    t.integer  "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
    t.integer  "maximum_score"
  end

  create_table "audit_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audit_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audits", force: true do |t|
    t.string   "title"
    t.text     "scope"
    t.text     "context"
    t.text     "methodology"
    t.text     "deliverables"
    t.string   "issue"
    t.integer  "company_id"
    t.integer  "audit_type_id"
    t.integer  "audit_status_id"
    t.string   "compliance_type"
    t.integer  "standard_id"
    t.integer  "location_id"
    t.integer  "department_id"
    t.integer  "team_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "auditor"
    t.text     "objective"
    t.integer  "client_id"
    t.text     "close_reason"
    t.integer  "risk_id"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "percentage"
  end

  create_table "checklist_recommendations", force: true do |t|
    t.integer  "checklist_id"
    t.string   "checklist_type"
    t.integer  "auditee_id"
    t.text     "recommendation"
    t.text     "reason"
    t.text     "corrective"
    t.text     "preventive"
    t.date     "closure_date"
    t.integer  "recommendation_priority_id"
    t.integer  "recommendation_severity_id"
    t.integer  "response_priority_id"
    t.integer  "response_severity_id"
    t.integer  "recommendation_status_id"
    t.integer  "response_status_id"
    t.integer  "dependent_recommendation"
    t.integer  "blocking_recommendation"
    t.text     "observation"
    t.boolean  "is_implemented",             default: false
    t.boolean  "recommendation_completed",   default: false
    t.boolean  "response_completed",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_published"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "contact_no"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "close_reasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "closures", force: true do |t|
    t.integer  "risk_id"
    t.integer  "user_id"
    t.date     "closure_date"
    t.integer  "close_reason_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "primary_email"
    t.string   "secondary_email"
    t.string   "domain"
    t.string   "address1"
    t.string   "address2"
    t.string   "timezone"
    t.integer  "country_id"
    t.string   "contact_no"
    t.boolean  "is_disabled",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compliance_libraries", force: true do |t|
    t.string   "name"
    t.integer  "compliance_id"
    t.boolean  "is_leaf"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compliances", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "control_measures", force: true do |t|
    t.integer  "risk_id"
    t.string   "control_ids",     default: [], array: true
    t.text     "threat"
    t.text     "consequence"
    t.string   "effectiveness"
    t.integer  "risk_scoring_id"
    t.string   "process_ids",     default: [], array: true
    t.string   "procedure_ids",   default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string "name"
    t.string "iso_two_letter_code"
  end

  create_table "cpp_measures", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "type"
    t.integer  "implementation_status_id"
    t.integer  "compliance_id"
    t.integer  "duration"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "departments", force: true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "implementation_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mgmt_reviews", force: true do |t|
    t.integer  "risk_id"
    t.integer  "review_id"
    t.integer  "reviewer"
    t.integer  "next_step_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mitigation_efforts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mitigations", force: true do |t|
    t.integer  "risk_id"
    t.integer  "planning_strategy_id"
    t.integer  "mitigation_effort_id"
    t.text     "current_solution"
    t.text     "security_requirements"
    t.text     "security_recommendations"
    t.integer  "submitted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "modulars", force: true do |t|
    t.string   "model_name"
    t.string   "action_name"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nc_questions", force: true do |t|
    t.string   "question"
    t.integer  "audit_id"
    t.integer  "question_type_id"
    t.integer  "priority_id"
    t.date     "target_date"
    t.boolean  "does_require_document"
    t.integer  "company_id"
    t.integer  "auditee_id"
    t.boolean  "nc_library"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_answered",           default: false
  end

  create_table "next_steps", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operational_areas", force: true do |t|
    t.integer  "compliance_library_id"
    t.integer  "weightage"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planning_strategies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priorities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privileges", force: true do |t|
    t.integer  "role_id"
    t.integer  "modular_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "personal_email"
    t.string   "phone_no"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_options", force: true do |t|
    t.integer  "nc_question_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendation_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminder_assignments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminder_mails", force: true do |t|
    t.string   "mail_type"
    t.integer  "mail_id"
    t.integer  "mail_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", force: true do |t|
    t.integer  "value"
    t.integer  "priority_id"
    t.integer  "company_id"
    t.integer  "time_line"
    t.datetime "last_sent"
    t.integer  "to"
    t.integer  "cc"
    t.integer  "mail_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_approval_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_models", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_review_levels", force: true do |t|
    t.string   "name"
    t.integer  "days"
    t.integer  "company_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risks", force: true do |t|
    t.string   "subject"
    t.string   "control_number"
    t.text     "assessment"
    t.text     "notes"
    t.integer  "risk_status_id"
    t.integer  "reference"
    t.integer  "compliance_id"
    t.integer  "location_id"
    t.integer  "category_id"
    t.integer  "team_id"
    t.integer  "technology_id"
    t.integer  "owner"
    t.date     "review_date"
    t.integer  "project_id"
    t.integer  "submitted_by"
    t.integer  "risk_approval_status_id"
    t.integer  "company_id"
    t.integer  "risk_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "title"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "level"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skipped_audit_reminders", force: true do |t|
    t.integer  "audit_id"
    t.integer  "skipped_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.integer  "company_id"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technologies", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_teams", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "full_name"
    t.string   "user_name"
    t.integer  "role_id"
    t.integer  "department_id"
    t.integer  "company_id"
    t.string   "authentication_token"
    t.integer  "manager"
    t.integer  "language_id"
    t.string   "timezone"
    t.boolean  "is_disabled",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
