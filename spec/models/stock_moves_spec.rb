require "rails_helper"

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
