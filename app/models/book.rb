class Book < ApplicationRecord
  has_many :stock_moves, dependent: :destroy
  has_many :stocks, dependent: :destroy
  validates :title, :rack_number, :isbn, presence: true
  validates :rack_number, :isbn, uniqueness: true

  def invalid_order_timing?
    return false if special_order_date_time.blank? || order_date_time.blank?
    special_order_date_time < order_date_time
  end

  def formatted_order_date_time
    return nil unless order_date_time.present?
    I18n.l(order_date_time, format: :datetime_jp)
  end

  def formatted_special_order_date_time
    return nil unless special_order_date_time.present?
    I18n.l(special_order_date_time, format: :datetime_jp)
  end
end
