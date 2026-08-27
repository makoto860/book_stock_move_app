require 'rails_helper'

RSpec.describe "stock_moves", type: :system do
  describe "在庫を移動する画面" do
    let!(:book) { create(:book) }
    let!(:warehouse) { create(:location, :warehouse) }
    let!(:pick) { create(:location, :pick) }
    let!(:stock) do
      create(:stock, book: book, location: warehouse)
    end

    before do
      visit new_stock_move_path
    end

    it "タイトルが表示されること" do
      expect(page).to have_select("タイトル")
    end

    it "移動元が表示されること" do
      expect(page).to have_select("移動元")
    end

    it "移動先が表示されること" do
      expect(page).to have_select("移動先")
    end

    it "数が表示されること" do
      expect(page).to have_content("数")
    end
    
    it "在庫を移動するボタンが表示されること" do
      expect(page).to have_button("在庫を移動する")
    end

    it "在庫を移動するボタンをクリックすると在庫の移動した履歴一覧画面に遷移すること" do
      select book.title, from: "タイトル"
      select warehouse.name, from: "移動元"
      select pick.name, from: "移動先"
      fill_in "stock_move_quantity", with: 1
      click_button "在庫を移動する"
      click_button "在庫の移動を確定する"
      expect(page).to have_current_path(stock_moves_path)
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
