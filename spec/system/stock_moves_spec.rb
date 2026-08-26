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
      visit confirm_stock_moves_path(
        stock_move: {
          book_id: book.id,
          from_location_id: from_location.id,
          to_location_id: to_location.id,
          quantity: 3
        }
      )
    end

    context "正常に在庫の移動ができるとき" do
      it "教科書のタイトルが表示されること" do
        expect(page).to have_content(book.title)
      end

      it "教科書のIDが表示されること" do
      end

      it "在庫の移動を確定するを押すと在庫移動履歴一覧へ遷移すること" do
      end
    end
  end
end
