class StocksController < ApplicationController
  def index
    @books = Book.includes(stocks: :location)
  end
end
