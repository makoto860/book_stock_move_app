require 'rails_helper'

RSpec.describe "stock_moves", type: :system do
  describe "在庫移動履歴を登録する画面" do
    before do
      visit new_stock_move_path
    end

    it "入力欄が表示されること" do
      expect(page).to have_field("タイトル")
      expect(page).to have_field("移動元")
      expect(page).to have_field("移動先")
      expect(page).to have_field("数")
    end

    it "教科書を選択できること" do
      expect(page).to have_select("stock_move_book_id")
    end

    it "在庫を移動するボタンが表示されること" do
      expect(page).to have_button("在庫を移動する")
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

    context "確認画面で在庫移動を確定したとき" do
      before do
        fill_in "stock_move_quantity", with: 3
        click_button "在庫を移動する"
        click_button "在庫の移動を確定する"
      end

      it "成功メッセージが表示されること" do
        expect(page).to have_content("教科書を移動しました")
      end

      it "在庫移動履歴一覧へ遷移すること" do
        expect(page).to have_current_path(stock_moves_path)
      end
    end

    context "在庫不足のとき" do
      before do
        fill_in "stock_move_quantity", with: 4
        click_button "在庫を移動する"
        click_button "在庫の移動を確定する"
      end

      it "在庫不足のメッセージが表示されること" do
        expect(page).to have_content("在庫不足です")
      end
      
      it "確認画面へ戻ること" do
        expect(page).to have_current_path(confirm_stock_moves_path, ignore_query: true)
      end
    end
  end
end
