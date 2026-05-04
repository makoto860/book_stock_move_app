class ChangeReservationDateNullInBooks < ActiveRecord::Migration[8.0]
  def change
    change_column_null :books, :reservation_date, true
    change_column_null :books, :order_date, true
  end
end
