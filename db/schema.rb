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

ActiveRecord::Schema[7.1].define(version: 2024_08_26_121219) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies_users", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.index ["company_id", "user_id"], name: "index_companies_users_on_companies"
    t.index ["user_id", "company_id"], name: "index_companies_users_on_user"
  end

  create_table "day_schedulings", force: :cascade do |t|
    t.date "date"
    t.time "start_work"
    t.time "end_work"
    t.time "start_break"
    t.time "end_break"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_day_schedulings_on_employee_id"
  end

  create_table "directors_employees", id: false, force: :cascade do |t|
    t.bigint "director_id", null: false
    t.bigint "employee_id", null: false
    t.index ["director_id", "employee_id"], name: "index_directors_employees_on_director"
    t.index ["employee_id", "director_id"], name: "index_directors_employees_on_employee"
  end

  create_table "employees_day_schedulings", id: false, force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "day_scheduling_id", null: false
    t.index ["day_scheduling_id", "employee_id"], name: "index_employees_day_schedulings_on_day_scheduling"
    t.index ["employee_id", "day_scheduling_id"], name: "index_employees_day_Schedulings_on_employee"
  end

  create_table "employees_salaires", id: false, force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "salaire_id", null: false
    t.index ["employee_id", "salaire_id"], name: "index_employees_salaires_on_employee"
    t.index ["salaire_id", "employee_id"], name: "index_employees_salaires_on_salaire"
  end

  create_table "holidays", force: :cascade do |t|
    t.integer "taken"
    t.integer "left"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id", null: false
    t.index ["employee_id"], name: "index_holidays_on_employee_id"
    t.index ["user_id"], name: "index_holidays_on_user_id"
  end

  create_table "salaires", force: :cascade do |t|
    t.date "date"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_salaires_on_employee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome"
    t.string "cognome"
    t.date "data_di_nascita"
    t.text "descrizione"
    t.string "ruolo", default: "dipendente"
    t.string "provider", limit: 50, default: "", null: false
    t.string "uid", limit: 50, default: "", null: false
    t.integer "company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "day_schedulings", "users", column: "employee_id"
  add_foreign_key "holidays", "users"
  add_foreign_key "holidays", "users", column: "employee_id"
  add_foreign_key "salaires", "users", column: "employee_id"
end
