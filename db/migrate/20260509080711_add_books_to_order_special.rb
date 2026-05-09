class AddBooksToOrderSpecial < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :order_date_time, :datetime
    add_column :books, :special_order_date_time, :datetime
  end
end
