require "rails_helper"

RSpec.describe Book, type: :model do
  describe "バリデーション" do
    context "titleが存在する場合" do
      let(:book) { build(:book) }

      it '有効であること' do
        expect(book).to be_valid
      end
    end

    context "titleが存在しない場合" do
      let(:book) { build(:book, title: nil) }

      it "無効であること" do
        expect(book).not_to be_valid
      end
    end
  end

  describe "invalid_order_timing?メソッド" do
    context "取り寄せ日時が注文日時より前の場合" do
      let(:book) do
        create(:book, special_order_date_time: 1.day.ago, order_date_time: Time.current)
      end

      it "trueを返すこと" do
        expect(book.invalid_order_timing?).to be true
      end
    end

    context "取り寄せ日時が注文日時より後の場合" do
      let(:book) { create(:book, :valid_order_timing) }

      it "falseを返すこと" do
        expect(book.invalid_order_timing?).to be false
      end
    end
  end
end
