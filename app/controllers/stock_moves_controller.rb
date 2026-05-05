class StockMovesController < ApplicationController
  def index
    @books = Book.all
    @stock_moves = StockMove.includes(:book, :from_location, :to_location)
    @warehouse = Location.find_by!(kind: "warehouse")
  end

  def new
  end

  def create
  end
end
