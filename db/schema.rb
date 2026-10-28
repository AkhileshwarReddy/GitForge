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

ActiveRecord::Schema[8.1].define(version: 2026_10_28_180026) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "audit_logs", force: :cascade do |t|
    t.string "auditable_type", null: false
    t.bigint "auditable_id", null: false
    t.string "action", null: false
    t.jsonb "changeset", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_audit_logs_on_auditable"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "organisation_id", null: false
    t.bigint "user_id", null: false
    t.integer "access_level", default: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organisation_id", "user_id"], name: "index_memberships_on_organisation_id_and_user_id", unique: true
    t.index ["organisation_id"], name: "index_memberships_on_organisation_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name", limit: 120, null: false
    t.string "slug", limit: 80, null: false
    t.integer "plan", default: 0, null: false
    t.string "billing_email"
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "storage_limit_bytes", default: 5368709120, null: false
    t.jsonb "settings", default: {}, null: false
    t.datetime "trial_ends_at"
    t.datetime "deleted_at"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "organisation_id", null: false
    t.bigint "creator_id", null: false
    t.string "name", limit: 120, null: false
    t.string "path", limit: 80, null: false
    t.integer "visibility", default: 0, null: false
    t.integer "stars_count", default: 0, null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pinned", default: false, null: false
    t.index ["creator_id"], name: "index_projects_on_creator_id"
    t.index ["organisation_id", "path"], name: "index_projects_on_organisation_id_and_path", unique: true
    t.index ["organisation_id"], name: "index_projects_on_organisation_id"
  end

  create_table "repository_configs", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "default_branch", default: "main", null: false
    t.string "merge_method", default: "merge_commit", null: false
    t.boolean "lfs_enabled", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_repository_configs_on_project_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", limit: 60, null: false
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.jsonb "preferences", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
    t.check_constraint "failed_attempts >= 0", name: "chk_users_failed_attempts_non_negative"
  end

  add_foreign_key "memberships", "organisations", on_delete: :cascade
  add_foreign_key "memberships", "users", on_delete: :cascade
  add_foreign_key "projects", "organisations", on_delete: :cascade
  add_foreign_key "projects", "users", column: "creator_id", on_delete: :restrict
  add_foreign_key "repository_configs", "projects", on_delete: :cascade
end
