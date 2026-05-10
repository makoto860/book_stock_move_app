class StockMove < ApplicationRecord
  belongs_to :book
  belongs_to :from_location, class_name: "Location"
  belongs_to :to_location, class_name: "Location"
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def from_stock
    Stock.find_by(book_id: book_id, location_id: from_location_id)
  end

  def to_stock
    Stock.find_by(book_id: book_id, location_id: to_location_id)
  end
end
