class StockMovesController < ApplicationController
  def index
    @books = Book.all
    @stock_moves = StockMove.includes(:book, :from_location, :to_location)
    if params[:q].present?
      @stock_moves = @stock_moves.joins(:book, :from_location, :to_location)
      if params[:q].match?(/\A\d+\z/)
        @stock_moves = @stock_moves.where(
          "books.title ILIKE :q
           OR locations.name ILIKE :q
           OR to_locations_stock_moves.name ILIKE :q
           OR stock_moves.quantity = :quantity",
          q: "%#{params[:q]}%",
          quantity: params[:q].to_i
        )
      else
        @stock_moves = @stock_moves.where(
          "books.title ILIKE :q
           OR locations.name ILIKE :q
           OR to_locations_stock_moves.name ILIKE :q",
          q: "%#{params[:q]}%"
        )
      end
    end

    direction = params[:order] == "asc" ? :asc : :desc
    case params[:sort]
    when "quantity"
      @stock_moves = @stock_moves.order(quantity: direction)
    when "created_at"
      @stock_moves = @stock_moves.order(created_at: direction)
    else
      @stock_moves = @stock_moves.order(created_at: :desc)
    end

    @stock_moves = @stock_moves.page(params[:page]).per(15)
  end

  def new
    @stock_move = StockMove.new
    @locations = Location.all
    @books = Book.all
  end

  def create
    StockTransferService.call(stock_move_params)
    redirect_to stock_moves_path, notice: "教科書を移動しました"
  rescue => e
    redirect_to confirm_stock_moves_path(stock_move: stock_move_params.to_h), alert: e.message
  end

  def confirm
    @stock_move = StockMove.new(stock_move_params)
    if params[:book_id_search].present?
      @stock_move.book = Book.find(params[:book_id_search])
    end
  end

  private

  def stock_move_params
    params.require(:stock_move).permit(:book_id, :from_location_id, :to_location_id, :quantity, :move_type)
  end
end
