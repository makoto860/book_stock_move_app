require "rails_helper"

RSpec.describe Stock, type: :model do
  describe "バリデーション" do
    let(:stock) { build(:stock) }

    it "有効な在庫情報であること" do
      expect(stock).to be_valid
    end
  end
end
