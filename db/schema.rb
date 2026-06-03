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

ActiveRecord::Schema[8.1].define(version: 2026_05_25_212923) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.datetime "assigned_at"
    t.string "assigned_by"
    t.string "condition_in"
    t.string "condition_out"
    t.datetime "created_at", null: false
    t.bigint "equipment_id"
    t.date "expected_return_date"
    t.text "notes"
    t.datetime "returned_at"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["equipment_id"], name: "index_assignments_on_equipment_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "departments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_departments_on_tenant_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.string "asset_tag"
    t.string "brand"
    t.datetime "created_at", null: false
    t.bigint "equipment_category_id"
    t.bigint "location_id"
    t.string "model"
    t.text "notes"
    t.date "purchase_date"
    t.decimal "purchase_price"
    t.string "serial_number"
    t.string "status"
    t.bigint "supplier_id"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.date "warranty_end"
    t.index ["equipment_category_id"], name: "index_equipment_on_equipment_category_id"
    t.index ["location_id"], name: "index_equipment_on_location_id"
    t.index ["supplier_id"], name: "index_equipment_on_supplier_id"
    t.index ["tenant_id"], name: "index_equipment_on_tenant_id"
  end

  create_table "equipment_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lifespan_years"
    t.string "name"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_equipment_categories_on_tenant_id"
  end

  create_table "equipment_events", force: :cascade do |t|
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.bigint "equipment_id"
    t.date "event_date"
    t.string "event_type"
    t.text "notes"
    t.string "performed_by"
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_equipment_events_on_equipment_id"
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_locations_on_tenant_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "contact_email"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.string "name"
    t.text "notes"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_suppliers_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "plan", default: "free"
    t.string "subdomain", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain"], name: "index_tenants_on_subdomain", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "department_id"
    t.datetime "discarded_at"
    t.string "document_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.date "hire_date"
    t.string "name"
    t.string "phone"
    t.string "position"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "consulta", null: false
    t.bigint "tenant_id"
    t.date "termination_date"
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  add_foreign_key "assignments", "equipment"
  add_foreign_key "assignments", "users"
  add_foreign_key "departments", "tenants"
  add_foreign_key "equipment", "equipment_categories"
  add_foreign_key "equipment", "locations"
  add_foreign_key "equipment", "suppliers"
  add_foreign_key "equipment", "tenants"
  add_foreign_key "equipment_categories", "tenants"
  add_foreign_key "equipment_events", "equipment"
  add_foreign_key "locations", "tenants"
  add_foreign_key "suppliers", "tenants"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "tenants"
end
