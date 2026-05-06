class StockMovesController < ApplicationController
  def index
    @books = Book.all
    @stock_moves = StockMove.includes(:book, :from_location, :to_location)
    @warehouse = Location.find_by!(kind: "warehouse")
  end

  def new
    @book = Book.find(params[:book_id])
    @stock_move = @book.stock_moves.build
    @warehouses = Location.where(kind: "warehouse")
    @stores = Location.where(kind: "pick")
  end

  def create
    @book = Book.find(params[:book_id])
    @stock_move = @book.stock_moves.build(stock_move_params)
    if @stock_move.invalid?
      @warehouses = Location.where(kind: "warehouse")
      @stores = Location.where(kind: "pick")
      return render :new
    end
    StockTransferService.call(
      book: @book,
      from_location: Location.find(@stock_move.from_location_id),
      to_location: Location.find(@stock_move.to_location_id),
      quantity: @stock_move.quantity
    )
    redirect_to books_path, notice: "在庫を移動しました"
  end

  private

  def stock_move_params
    params.require(:stock_move).permit(:quantity, :move_type)
  end
end
