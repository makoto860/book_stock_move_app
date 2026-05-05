class Stock < ApplicationRecord
  belongs_to :book
  belongs_to :location

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
