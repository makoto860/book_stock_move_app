class Book < ApplicationRecord
  has_many :stock_moves
  validates :title, presence: true
  validates :rack_number, presence: true, uniqueness: true
  validates :isbn, presence: true, uniqueness: true
end
