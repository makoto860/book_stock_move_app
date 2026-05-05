class Book < ApplicationRecord
  validates :title, presence: true
  validates :book_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :rack_number, presence: true
  validates :isbn, presence: true
end
