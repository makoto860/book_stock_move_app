class ChangeRackNumberNullInBooks < ActiveRecord::Migration[8.0]
  def change
    change_column_null :books, :rack_number, true
  end
end
