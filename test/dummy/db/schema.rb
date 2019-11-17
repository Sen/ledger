# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_11_041450) do

  create_table "ookkee_accounts", force: :cascade do |t|
    t.string "name"
    t.string "sheet_name"
    t.index ["sheet_name"], name: "index_ookkee_accounts_on_sheet_name"
  end

  create_table "ookkee_entries", force: :cascade do |t|
    t.integer "sheet_id"
    t.string "sheet_name"
    t.string "account_id"
    t.string "entry_type"
    t.decimal "amount", precision: 30, scale: 10
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "user_type"
    t.integer "user_id"
    t.index "\"acount_id\"", name: "index_ookkee_entries_on_acount_id"
    t.index ["entry_type"], name: "index_ookkee_entries_on_entry_type"
    t.index ["sheet_id"], name: "index_ookkee_entries_on_sheet_id"
    t.index ["sheet_name"], name: "index_ookkee_entries_on_sheet_name"
    t.index ["trackable_id"], name: "index_ookkee_entries_on_trackable_id"
    t.index ["trackable_type"], name: "index_ookkee_entries_on_trackable_type"
    t.index ["user_id"], name: "index_ookkee_entries_on_user_id"
    t.index ["user_type"], name: "index_ookkee_entries_on_user_type"
  end

  create_table "ookkee_sheets", force: :cascade do |t|
    t.string "title"
    t.string "transaction_number"
    t.index ["transaction_number"], name: "index_ookkee_sheets_on_transaction_number", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
