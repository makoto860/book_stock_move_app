module StocksHelper
  def stock_color_class(stock)
    stock.quantity.to_i > 0 ? "quantity-color-full" : "quantity-color-empty"
  end
end
