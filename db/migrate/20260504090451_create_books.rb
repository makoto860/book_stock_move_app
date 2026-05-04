class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string "title", null: false
      t.integer "book_quantity", default: 0, null: false
      t.integer "rack_number", null: false
      t.integer "isbn", null: false
      t.datetime "reservation_date", null: false
      t.datetime "order_date", null: false

      t.timestamps
    end
  end
end
