class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:book, :location)
  end

  def new
    @stock = Stock.new
    @books = Book.all
    @locations = Location.all
  end

  def create
    @stock = Stock.find_or_initialize_by(
      book_id: stock_params[:book_id],
      location_id: stock_params[:location_id]
    )

    @stock.quantity ||= 0
    @stock.quantity += stock_params[:quantity].to_i

    if @stock.save
      redirect_to stocks_path, notice: "在庫を登録しました"
    else
      @books = Book.all
      @locations = Location.all
      render :new
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:book_id, :location_id, :quantity)
  end
end
