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
    redirect_to stock_moves_path, notice: "教科書を移動しました"
  rescue => e
    redirect_to confirm_stock_moves_path(stock_move: stock_move_params.to_h), alert: e.message
  end

  def confirm
    @stock_move = StockMove.new(stock_move_params)
  end

  private

  def stock_move_params
    params.require(:stock_move).permit(:book_id, :from_location_id, :to_location_id, :quantity, :move_type)
  end
end
