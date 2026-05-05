class StockTransferService
  def self.call(book:, from_location:, to_location:, quantity:)
    ActiveRecord::Base.transaction do
      from_stock = Stock.find_by!(book: book, location: from_location)
      to_stock   = Stock.find_or_initialize_by(book: book, location: to_location)

      from_stock.lock!

      raise "在庫を移動したときに不足しています" if from_stock.quantity < quantity

      from_stock.update!(quantity: from_stock.quantity - quantity)

      to_stock.quantity ||= 0
      to_stock.update!(quantity: to_stock.quantity + quantity)
    end
  end
end
