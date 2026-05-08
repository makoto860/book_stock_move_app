class CreateStocks < ActiveRecord::Migration[8.0]
  def change
    create_table :stocks do |t|
      t.integer "book_id", null: false
      t.integer "location_id", null: false
      t.integer "quantity", default: 0, null: false
      t.index ["book_id", "location_id"], name: "index_stocks_on_book_id_and_location_id", unique: true
      t.index ["book_id"], name: "index_stocks_on_book_id"
      t.index ["location_id"], name: "index_stocks_on_location_id"

      t.timestamps
    end
  end
end
