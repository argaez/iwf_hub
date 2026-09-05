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

ActiveRecord::Schema[8.1].define(version: 2026_09_05_205606) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.date "warranty_end"
    t.index ["equipment_category_id"], name: "index_equipment_on_equipment_category_id"
    t.index ["location_id"], name: "index_equipment_on_location_id"
    t.index ["tenant_id"], name: "index_equipment_on_tenant_id"
    t.index ["vendor_id"], name: "index_equipment_on_vendor_id"
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

  create_table "extension_ranges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "label", null: false
    t.integer "range_end", null: false
    t.integer "range_start", null: false
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_extension_ranges_on_tenant_id"
  end

  create_table "extensions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "notes"
    t.integer "number", null: false
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["tenant_id", "number"], name: "index_extensions_on_tenant_id_and_number", unique: true
    t.index ["tenant_id"], name: "index_extensions_on_tenant_id"
    t.index ["user_id"], name: "index_extensions_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_locations_on_tenant_id"
  end

  create_table "onboarding_requests", force: :cascade do |t|
    t.json "applications", default: []
    t.string "applications_other"
    t.boolean "brand_new_phone", default: false
    t.datetime "created_at", null: false
    t.json "distribution_lists", default: []
    t.boolean "existing_phone", default: false
    t.bigint "extension_id"
    t.boolean "new_computer", default: false
    t.boolean "new_remote_user", default: false
    t.text "notes"
    t.string "pc_asset_tag"
    t.string "pc_name_or_previous_owner"
    t.string "previous_remote_user"
    t.boolean "remote_access_needed", default: false
    t.string "remote_department"
    t.date "request_date", null: false
    t.date "start_date"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["extension_id"], name: "index_onboarding_requests_on_extension_id"
    t.index ["tenant_id"], name: "index_onboarding_requests_on_tenant_id"
    t.index ["user_id"], name: "index_onboarding_requests_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.boolean "can_create", default: false, null: false
    t.boolean "can_destroy", default: false, null: false
    t.boolean "can_index", default: false, null: false
    t.boolean "can_show", default: false, null: false
    t.boolean "can_update", default: false, null: false
    t.datetime "created_at", null: false
    t.string "resource", null: false
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.index ["role", "resource"], name: "index_permissions_on_role_and_resource", unique: true
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

  create_table "user_equipment_requirements", force: :cascade do |t|
    t.string "adapter_name"
    t.bigint "assignment_id"
    t.datetime "created_at", null: false
    t.bigint "equipment_category_id", null: false
    t.boolean "is_adapter", default: false, null: false
    t.integer "position", default: 0, null: false
    t.boolean "requires", default: true, null: false
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["assignment_id"], name: "index_user_equipment_requirements_on_assignment_id"
    t.index ["equipment_category_id"], name: "index_user_equipment_requirements_on_equipment_category_id"
    t.index ["tenant_id"], name: "index_user_equipment_requirements_on_tenant_id"
    t.index ["user_id", "equipment_category_id", "is_adapter"], name: "index_uer_on_user_category_adapter"
    t.index ["user_id"], name: "index_user_equipment_requirements_on_user_id"
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

  create_table "vendors", force: :cascade do |t|
    t.string "contact_email"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.string "name"
    t.text "notes"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_vendors_on_tenant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assignments", "equipment"
  add_foreign_key "assignments", "users"
  add_foreign_key "departments", "tenants"
  add_foreign_key "equipment", "equipment_categories"
  add_foreign_key "equipment", "locations"
  add_foreign_key "equipment", "tenants"
  add_foreign_key "equipment", "vendors"
  add_foreign_key "equipment_categories", "tenants"
  add_foreign_key "equipment_events", "equipment"
  add_foreign_key "extension_ranges", "tenants"
  add_foreign_key "extensions", "tenants"
  add_foreign_key "extensions", "users"
  add_foreign_key "locations", "tenants"
  add_foreign_key "onboarding_requests", "extensions"
  add_foreign_key "onboarding_requests", "tenants"
  add_foreign_key "onboarding_requests", "users"
  add_foreign_key "user_equipment_requirements", "assignments"
  add_foreign_key "user_equipment_requirements", "equipment_categories"
  add_foreign_key "user_equipment_requirements", "tenants"
  add_foreign_key "user_equipment_requirements", "users"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "tenants"
  add_foreign_key "vendors", "tenants"
end
