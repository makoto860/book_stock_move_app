class StockTransferService
  def self.call(params)
    book = Book.find(params[:book_id])
    from = Location.find(params[:from_location_id])
    to   = Location.find(params[:to_location_id])
    qty  = params[:quantity].to_i

    ActiveRecord::Base.transaction do
      from_stock = Stock.find_by!(book: book, location: from)
      to_stock   = Stock.find_or_initialize_by(book: book, location: to)
      to_stock.quantity ||= 0

      from_stock.with_lock do
        raise "在庫不足です" if from_stock.quantity < qty

        from_stock.decrement!(:quantity, qty)
        to_stock.increment!(:quantity, qty)
      end

      StockMove.create!(
        book: book,
        from_location: from,
        to_location: to,
        quantity: qty,
        move_type: :transfer
      )
    end
  end
end
