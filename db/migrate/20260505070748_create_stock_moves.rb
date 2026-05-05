class CreateStockMoves < ActiveRecord::Migration[8.0]
  def change
    create_table :stock_moves do |t|
      t.integer "book_id", null: false
      t.integer "from_location_id", null: false
      t.integer "to_location_id", null: false
      t.integer "quantity", null: false
      t.string "move_type", null: false
      t.index ["book_id"], name: "index_stock_moves_on_book_id"
      t.index ["from_location_id"], name: "index_stock_moves_on_from_location_id"
      t.index ["move_type"], name: "index_stock_moves_on_move_type"
      t.index ["to_location_id"], name: "index_stock_moves_on_to_location_id"

      t.timestamps
    end
  end
end
