class Book < ApplicationRecord
  has_many :stock_moves
  validates :title, presence: true
  validates :rack_number, presence: true
  validates :isbn, presence: true
end
