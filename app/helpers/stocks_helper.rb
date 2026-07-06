module StocksHelper
  def stock_color_class(stock)
    stock.quantity.to_i > 0 ? "color-quantity-exist" : "color-quantity-not-exist"
  end
end
