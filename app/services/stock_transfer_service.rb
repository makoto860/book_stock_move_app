class StockTransferService
  def self.call(book:, from_location:, to_location:, quantity:)
    ActiveRecord::Base.transaction do
      from_stock = Stock.find_by!(book: book, location: from_location)
      to_stock   = Stock.find_or_initialize_by(book: book, location: to_location)
      to_stock.quantity ||= 0

      from_stock.with_lock do
        raise "在庫不足です" if from_stock.quantity < quantity

        from_stock.decrement!(:quantity, quantity)
        to_stock.increment!(:quantity, quantity)
      end

      StockMove.create!(
        book: book,
        from_location: from_location,
        to_location: to_location,
        quantity: quantity
      )
    end
  end
end