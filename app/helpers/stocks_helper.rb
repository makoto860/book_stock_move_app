module StocksHelper
  def stock_color_class(stock)
    stock.quantity.to_i > 0 ? "text-green" : "text-red"
  end
end
