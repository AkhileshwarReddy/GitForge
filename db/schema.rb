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

ActiveRecord::Schema[8.1].define(version: 2026_10_28_070319) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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
end
