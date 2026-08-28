require 'rails_helper'

RSpec.describe "stock_moves", type: :system do
  describe "在庫履歴の一覧画面" do
    let!(:book) { create(:book) }
    let!(:from_location) { create(:location) }
    let!(:to_location) { create(:location) }
    let!(:stock_move) do
      create(:stock_move, book: book, from_location: from_location, to_location: to_location, quantity: 1, move_type: "transfer")
    end

    before do
      visit stock_moves_path
    end

    it "タイトルが表示されること" do
      expect(page).to have_content(book.title)
    end

    it "移動元が表示されること" do
      expect(page).to have_content(from_location.name)
    end

    it "移動先が表示されること" do
      expect(page).to have_content(to_location.name)
    end

    it "在庫数が表示されること" do
      expect(page).to have_content(stock_move.quantity)
    end

    it "作成日が表示されること" do
      expect(page).to have_content(I18n.l(book.created_at, format: :datetime_jp))
    end
  end

  describe "在庫移動履歴を登録する画面" do
    before do
      visit new_stock_move_path
    end

    it "ID検索の入力欄が表示されること" do
      expect(page).to have_field("book-id-search")
    end

    it "移動元の入力欄が表示されること" do
      expect(page).to have_select("stock_move_from_location_id")
    end

    it "移動先の入力欄が表示されること" do
      expect(page).to have_select("stock_move_to_location_id")
    end

    it "移動する数の入力欄が表示されること" do
      expect(page).to have_field("stock_move_quantity")
    end

    it "在庫を移動するボタンが表示されること" do
      expect(page).to have_button("在庫を移動する")
    end

    it "在庫を移動するボタンを押すと確認画面に遷移すること" do
      click_button "在庫を移動する"
      expect(page).to have_current_path(confirm_stock_moves_path, ignore_query: true)
    end
  end

  describe "在庫移動確認画面" do
    let!(:book) { create(:book) }
    let!(:from_location) { create(:location) }
    let!(:to_location) { create(:location) }
    let!(:stock_move) do
      create(:stock_move, from_location_id: from_location.id, to_location_id: to_location.id, quantity: 3)
    end
    let!(:stock) do
      create(:stock, book: book, location: from_location, quantity: 4)
    end

    before do
      visit confirm_stock_moves_path(
        book_id_search: book.id,
        stock_move: {
          book_id: book.id,
          from_location_id: from_location.id,
          to_location_id: to_location.id,
          quantity: 3,
          move_type: "transfer"
        }
      )
    end

    it "教科書IDが表示されること" do
      expect(page).to have_content(book.id)
    end

    it "タイトルが表示されること" do
      expect(page).to have_content(book.title)
    end

    it "移動する数が表示されること" do
      expect(page).to have_content(stock_move.quantity)
    end

    it "移動元が表示されること" do
      expect(page).to have_content(from_location.name)
    end

    it "移動先が表示されること" do
      expect(page).to have_content(to_location.name)
    end

    it "在庫の移動を確定するボタンがあること" do
      expect(page).to have_button("在庫の移動を確定する")
    end

    it "在庫の移動を確定するボタンをクリックすると在庫履歴の一覧画面に遷移すること" do
      click_button "在庫の移動を確定する"
      expect(page).to have_current_path(stock_moves_path)
    end
  end
end
