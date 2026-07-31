class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:book, :location)
    if params[:q].present?
      q = params[:q]
      @stocks = @stocks.joins(:book)
      if q.match?(/\A\d+\z/)
        @stocks = @stocks.where("books.title LIKE :q OR stocks.quantity = :quantity", q: "%#{q}%", quantity: q.to_i)
      else
        @stocks = @stocks.where("books.title LIKE ?", "%#{q}%")
      end
    end
    direction = params[:order] == "asc" ? :asc : :desc
    @stocks = @stocks.order(quantity: direction).page(params[:page]).per(15)
  end

  def new
    @stock = Stock.new
    @books = Book.all
    @locations = Location.all
  end

  def create
    StockRegistrationService.call(stock_params)
    redirect_to stocks_path, notice: "在庫を登録しました"
  rescue ActiveRecord::RecordInvalid
    @books = Book.all
    @locations = Location.all
    render :new
  end

  private

  def stock_params
    params.require(:stock).permit(:book_id, :location_id, :quantity)
  end
end
