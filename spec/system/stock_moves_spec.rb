require 'rails_helper'

RSpec.describe "stock_moves", type: :system do
  describe "在庫を移動する画面" do
    let!(:book) { create(:book) }
    let!(:from_location) { create(:location, :warehouse) }
    let!(:to_location) { create(:location, :pick) }
    let!(:from_stock) do
      create(:stock, book: book, location: from_location, quantity: 3)
    end

    before do
      visit new_stock_move_path
      select book.title, from: "stock_move_book_id"
      select from_location.name, from: "stock_move_from_location_id"
      select to_location.name, from: "stock_move_to_location_id"
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

    it "在庫を移動するをクリックすると在庫の移動した履歴一覧画面に遷移すること" do
      fill_in "stock_move_quantity", with: 1
      click_button "在庫を移動する"
      click_button "在庫の移動を確定する"
      expect(page).to have_current_path(stock_moves_path)
    end
  end

  describe "在庫移動確認画面" do
    let!(:book) { create(:book) }
    let!(:from_location) { create(:location, :warehouse) }
    let!(:to_location) { create(:location, :pick) }
    let!(:from_stock) do
      create(:stock, book: book, location: from_location, quantity: 3)
    end

    before do
      visit new_stock_move_path
      select book.title, from: "stock_move_book_id"
      select from_location.name, from: "stock_move_from_location_id"
      select to_location.name, from: "stock_move_to_location_id"
    end

    context "正常に在庫の移動ができるとき" do
      before do
        fill_in "stock_move_quantity", with: 1
        click_button "在庫を移動する"
        click_button "在庫の移動を確定する"
      end

      it "在庫の移動を確定すると在庫の移動履歴一覧で成功メッセージが表示されること" do
        expect(page).to have_current_path(stock_moves_path)
        expect(page).to have_content("教科書を移動しました")
      end

      it "教科書のタイトルが表示されること" do
      end

      it "教科書のIDが表示されること" do
      end

      it "在庫の移動を確定するを押すと在庫移動履歴一覧へ遷移すること" do
      end
    end
  end
end
