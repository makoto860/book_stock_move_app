class StockInitializerService
  def self.call(book:, quantity:)
    warehouse = Location.find_by!(kind: :warehouse)
    pick      = Location.find_by!(kind: :pick)

    ActiveRecord::Base.transaction do
      warehouse_stock = Stock.find_or_initialize_by(book: book, location: warehouse)
      warehouse_stock.quantity = quantity
      warehouse_stock.save!

      pick_stock = Stock.find_or_initialize_by(book: book, location: pick)
      pick_stock.quantity = 0
      pick_stock.save!
    end
  end
end
