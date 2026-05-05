class StockMovesController < ApplicationController
  def index
    @books = Book.all
    @stock_moves = StockMove.includes(:book, :from_location, :to_location)
    @warehouse = Location.find_by!(kind: "warehouse")
  end

  def new
    @book = Book.find(params[:book_id])
    @stock_move = @book.stock_moves.build
  end

  def create
    @book = Book.find(params[:book_id])
    stock_move = @book.stock_moves.new(stock_move_params)

    ActiveRecord::Base.transaction do
      if stock_move.move_type == "adjustment"
        new_qty = (@book.book_quantity || 0) + stock_move.quantity.to_i
        raise "在庫がマイナスになります" if new_qty < 0
        @book.update!(book_quantity: new_qty)
        redirect_to books_path
      else
        warehouse = Location.find_by!(kind: "warehouse")
        pick      = Location.find_by!(kind: "pick")
        customer  = Location.find_by!(kind: "customer")

        from, to = case stock_move.move_type
        when "to_pick"
          [warehouse, pick]
        when "to_customer"
          [pick, customer]
        else
          raise "不正なmove_typeです"
        end

        StockTransferService.call(
          book: @book,
          from_location: from,
          to_location: to,
          quantity: stock_move.quantity
        )

        stock_move.from_location = from
        stock_move.to_location   = to
        redirect_to books_path
      end
      stock_move.save!
    end
    redirect_to books_path
  end

  private

  def stock_move_params
    params.require(:stock_move).permit(:quantity, :move_type)
  end
end
