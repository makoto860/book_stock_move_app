class Book < ApplicationRecord
  has_many :stock_moves, dependent: :destroy
  has_many :stocks, dependent: :destroy
  validates :title, presence: true
  validates :rack_number, presence: true, uniqueness: true
  validates :isbn, presence: true, uniqueness: true

  def invalid_order_timing?
    return false if special_order_date_time.blank?
    return false if order_date_time.blank?

    special_order_date_time < order_date_time
  end
end
