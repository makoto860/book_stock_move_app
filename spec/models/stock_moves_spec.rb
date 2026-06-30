require "rails_helper"

RSpec.describe StockMove, type: :model do
  describe "バリデーション" do
    let(:stock_move) { build(:stock_move) }
    it "登録するときに有効であること" do
      expect(stock_move).to be_valid
    end

    context "数量が空の場合" do
      let(:stock_move) { build(:stock_move, quantity: nil) }

      it "無効になり登録できないこと" do
        expect(stock_move).not_to be_valid
      end
    end

    context "数量が0以下の場合" do
      let(:stock_move) { build(:stock_move, quantity: 0) }

      it "無効になり登録できないこと" do
        expect(stock_move).not_to be_valid
      end
    end
  end

  describe "from_location" do
    let(:stock_move) { build(:stock_move, book: book, from_location: from_location) }
    let(:book) { create(:book) }
    let(:from_location) { create(:location) }

    context "移動元の在庫が存在するとき" do
      let!(:stock) do
        create(:stock, book: book, location: from_location)
      end

      it "在庫が取得できること" do
        expect(stock_move.from_stock).to eq(stock)
      end
    end

    context "在庫が存在しないとき" do
      it "nilを返すこと" do
        expect(stock_move.from_stock).to be_nil
      end
    end
  end

  describe "to_location" do
    let(:stock_move) do
      build(:stock_move, book: book, to_location: to_location)
    end
    let(:book) { create(:book) }
    let(:to_location) { create(:location) }

    context "移動先の在庫が存在するとき" do
      let!(:stock) do
        create(:stock, book: book, location: to_location)
      end

      it "在庫が取得できること" do
        expect(stock_move.to_stock).to eq(stock)
      end
    end

    context "在庫が存在しないとき" do
      it "nilを返すこと" do
        expect(stock_move.to_stock).to be_nil
      end
    end
  end

  describe "アソシエーション" do
    it "bookと関連付けられていること" do
      expect(described_class.reflect_on_association(:book).macro).to eq(:belongs_to)
    end

    it "from_locationと関連付けられていること" do
      expect(described_class.reflect_on_association(:from_location).macro).to eq(:belongs_to)
    end

    it "to_locationと関連付けられていること" do
      expect(described_class.reflect_on_association(:to_location).macro).to eq(:belongs_to)
    end
  end
end
