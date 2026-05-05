class ChangeRackNumberAndIsbnToString < ActiveRecord::Migration[8.0]
  def change
    change_column :books, :rack_number, :string
    change_column :books, :isbn, :string
  end
end
