class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      # 本の初期在庫を倉庫に入れる
      StockInitializerService.call(
        book: @book,
        quantity: @book.book_quantity.to_i
      )
      redirect_to books_path, notice: "教科書を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @stock_move = @book.stock_moves.build
    @warehouses = Location.where(kind: "warehouse")
    @picks = Location.where(kind: "pick")
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :book_quantity, :isbn, :reservation_date, :order_date, :note)
  end
end
