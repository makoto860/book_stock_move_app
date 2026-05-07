class StockMovesController < ApplicationController
  def index
    @books = Book.all
    @stock_moves = StockMove.includes(:book, :from_location, :to_location).order(created_at: :desc)
  end

  def new
    @stock_move = StockMove.new
    @books = Book.all
    @locations = Location.all
  end

  def create
    StockTransferService.call(stock_move_params)
    redirect_to stock_moves_path, notice: "在庫を移動しました"
  end

  private

  def stock_move_params
    params.require(:stock_move).permit(:book_id, :from_location_id, :to_location_id, :quantity)
  end
end
