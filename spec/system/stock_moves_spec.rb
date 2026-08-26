require 'rails_helper'

RSpec.describe "stock_moves", type: :system do
  describe "在庫移動履歴を登録する画面" do
    before do
      create(:book)
      create(:location, :warehouse)
      create(:location, :pick)
      create(:location, :customer)
      visit new_stock_move_path
    end

    it "入力欄が表示されること" do
      expect(page).to have_field("タイトル")
      expect(page).to have_field("移動元")
      expect(page).to have_field("移動先")
      expect(page).to have_field("数")
    end

    it "在庫を移動するボタンが表示されること" do
      expect(page).to have_button("在庫を移動する")
    end
  end

  describe "在庫移動確認画面" do
    context "正常に在庫の移動ができるとき" do
      it "教科書のタイトルが表示されること" do
      end

      it "教科書のIDが表示されること" do
      end

      it "在庫の移動を確定するを押すと在庫移動履歴一覧へ遷移すること" do
      end
    end
  end
end
