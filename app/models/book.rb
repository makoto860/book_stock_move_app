class Book < ApplicationRecord
  has_many :stock_moves
  validates :title, presence: true
  validates :book_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :rack_number, presence: true
  validates :isbn, presence: true

  after_create :create_stocks

  def create_stocks
    # 全ての場所（倉庫・ピック場など）に対して、この本の在庫レコードを0で作る
    Location.find_each do |location|
      Stock.create!(book: self, location: location, quantity: 0)
    end
  end

  # この本の在庫を「0」で作成
  def stock_for(location)
    stocks.find_by(location: location)&.quantity || 0
  end
end
