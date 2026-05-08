class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string "name", null: false
      t.integer "kind", default: 0, null: false
      t.string "code"
      t.index ["code"], name: "index_locations_on_code", unique: true

      t.timestamps
    end
  end
end
