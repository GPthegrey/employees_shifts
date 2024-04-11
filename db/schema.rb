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

ActiveRecord::Schema[7.1].define(version: 2024_04_10_190733) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "shift_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_assignments_on_employee_id"
    t.index ["shift_id"], name: "index_assignments_on_shift_id"
  end

  create_table "bank_holidays", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.date "date_of_birth"
    t.string "position"
    t.string "email"
    t.string "phone"
    t.date "contract_start"
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "shift_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_requests_on_employee_id"
    t.index ["shift_id"], name: "index_requests_on_shift_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "day_of_week"
    t.string "turno"
    t.boolean "bank_holiday", default: false
    t.integer "number_employees", default: 2
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignments", "employees"
  add_foreign_key "assignments", "shifts"
  add_foreign_key "requests", "employees"
  add_foreign_key "requests", "shifts"
end
