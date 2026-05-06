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

ActiveRecord::Schema[8.0].define(version: 2026_05_06_085715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.integer "book_quantity", default: 0, null: false
    t.string "rack_number"
    t.string "isbn", null: false
    t.datetime "reservation_date"
    t.datetime "order_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "kind", default: 0, null: false
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_locations_on_code", unique: true
  end

  create_table "stock_moves", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "from_location_id", null: false
    t.integer "to_location_id", null: false
    t.integer "quantity", null: false
    t.string "move_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_stock_moves_on_book_id"
    t.index ["from_location_id"], name: "index_stock_moves_on_from_location_id"
    t.index ["move_type"], name: "index_stock_moves_on_move_type"
    t.index ["to_location_id"], name: "index_stock_moves_on_to_location_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "location_id", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "location_id"], name: "index_stocks_on_book_id_and_location_id", unique: true
    t.index ["book_id"], name: "index_stocks_on_book_id"
    t.index ["location_id"], name: "index_stocks_on_location_id"
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
end
