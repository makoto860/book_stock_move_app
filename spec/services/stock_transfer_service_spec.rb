require "rails_helper"

RSpec.describe StockTransferService, type: :service do
  describe ".callメソッド" do
    let!(:book) { create(:book) }
    let!(:from_location) { create(:location, :warehouse) }
    let!(:to_location) { create(:location, :pick) }
    let!(:from_stock) do
      create(:stock, book: book, location: from_location, quantity: 10)
    end
    let!(:to_stock) do
      create(:stock, book: book, location: to_location, quantity: 1)
    end
    let(:params) do
      { book_id: book.id, from_location_id: from_location.id, to_location_id: to_location.id, quantity: 3, move_type: :transfer }
    end

    it "移動元の在庫が減ること" do
      StockTransferService.call(params)
      expect(from_stock.reload.quantity).to eq(7)
    end

    it "移動先の在庫が増えること" do
      StockTransferService.call(params)
      expect(to_stock.reload.quantity).to eq(4)
    end

    it "移動履歴が1件登録されること" do
      expect do
        StockTransferService.call(params)
      end.to change(StockMove, :count).by(1)
    end

    context "移動元の在庫が不足しているとき" do
      let(:params) do
        { book_id: book.id, from_location_id: from_location.id, to_location_id: to_location.id, quantity: 11, move_type: :transfer }
      end

      it "在庫不足の例外が発生すること" do
        expect { StockTransferService.call(params) }.to raise_error(RuntimeError, "在庫不足です")
      end
    end
  end
end
