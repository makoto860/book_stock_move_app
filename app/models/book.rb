class Book < ApplicationRecord
  has_many :stock_moves, dependent: :destroy
  has_many :stocks, dependent: :destroy
  validates :title, presence: true
  validates :rack_number, presence: true, uniqueness: true
  validates :isbn, presence: true, uniqueness: true
end
