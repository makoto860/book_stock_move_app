class StockInitializerService
  # 初期在庫作成
  # call を呼ぶと実行される,book: → 対象の本,quantity: → 初期在庫数
  def self.call(book:, quantity:)
    # 場所を取得
    warehouse = Location.find_by!(kind: :warehouse)
    pick      = Location.find_by!(kind: :pick)

    ActiveRecord::Base.transaction do
      # 倉庫の在庫レコードを取得 or 作る,あればそれを使う,なければ新規作成
      warehouse_stock = Stock.find_or_initialize_by(book: book, location: warehouse)
      # 倉庫の在庫数をセットして保存,30冊登録したら → warehouse = 30
      warehouse_stock.quantity = quantity
      warehouse_stock.save!

      # ピック場の在庫レコードも取得 or 作成
      pick_stock = Stock.find_or_initialize_by(book: book, location: pick)
      # ピック場は必ず0で初期化
      pick_stock.quantity = 0
      pick_stock.save!
    end
  end
end
