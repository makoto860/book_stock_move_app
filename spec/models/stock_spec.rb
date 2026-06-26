require "rails_helper"

RSpec.describe Stock, type: :model do
  describe "バリデーション" do
    let(:stock) { build(:stock) }

    it "有効な在庫が登録できること" do
      expect(stock).to be_valid
    end

    context "quantityが0未満のとき" do
      let(:stock) { build(:stock, quantity: -1) }

      it "無効であり登録できないこと" do
        expect(stock).not_to be_valid
      end
    end

    context "同じbookとlocationのIDが存在するとき" do
      let!(:stock) { create(:stock) }
      let(:duplicate_stock) do
        build(:stock, book: stock.book, location: stock.location)
      end

      it "IDの組み合わせが重複になり無効になること" do
        expect(duplicate_stock).not_to be_valid
      end
    end
  end
end
