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

    @stocks =
    case params[:sort]
    when "quantity_desc"
      @stocks.order(quantity: :desc)
    when "quantity_asc"
      @stocks.order(quantity: :asc)
    else
      @stocks.order(created_at: :desc)
    end
  end

  def new
    @stock = Stock.new
    @books = Book.all
    @locations = Location.all
  end

  def create
    StockRegistrationService.call(stock_params)
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
