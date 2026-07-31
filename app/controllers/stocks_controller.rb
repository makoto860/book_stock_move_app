class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:book, :location)
    if params[:q].present?
      @stocks = @stocks.joins(:book, :location)
      if params[:q].match?(/\A\d+\z/)
        @stocks = @stocks.where(
          "books.title ILIKE :q
           OR locations.name ILIKE :q
           OR stocks.quantity = :quantity",
          q: "%#{params[:q]}%",
          quantity: params[:q].to_i
        )
      else
        @stocks = @stocks.where(
          "books.title ILIKE :q
           OR locations.name ILIKE :q",
          q: "%#{params[:q]}%"
        )
      end
    end

    direction = params[:order] == "asc" ? :asc : :desc
    case params[:sort]
    when "quantity"
      @stocks = @stocks.order(quantity: direction)
    when "created_at"
      @stocks = @stocks.order(created_at: direction)
    else
      @stocks = @stocks.order(created_at: :desc)
    end
    @stocks = @stocks.page(params[:page]).per(15)
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
