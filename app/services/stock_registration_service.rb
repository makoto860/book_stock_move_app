class StockRegistrationService
  def self.call(params)
    stock = Stock.find_or_initialize_by(book_id: params[:book_id], location_id: params[:location_id])
    stock.quantity ||= 0
    stock.quantity += params[:quantity].to_i
    stock.save!
    stock
  end
end
