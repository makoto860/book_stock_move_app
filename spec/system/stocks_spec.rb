require 'rails_helper'

RSpec.describe "stocks/", type: :system do
  let!(:stock) { create(:stock) }
  let!(:book) { create(:book) }
  let!(:location) { create(:location) }

  it "在庫一覧で在庫データが表示されること" do
    visit stocks_path
    expect(page).to have_content(stock.book.title)
    expect(page).to have_content(stock.location.name)
    expect(page).to have_content(stock.quantity)
    expect(page).to have_content(
      I18n.l(stock.created_at, format: :datetime_jp)
    )
  end

  describe "在庫の登録画面" do
    before do
      visit new_stock_path
    end

    it "ID検索の入力欄が表示されること" do
      expect(page).to have_field("book-id-search")
    end

    it "場所の入力欄が表示されること" do
      expect(page).to have_select("stock_location_id")
    end

    it "教科書の数の入力欄が表示されること" do
      expect(page).to have_field("stock_quantity")
    end

    it "教科書を登録するボタンを押すと在庫一覧画面に遷移すること" do
      click_button "教科書を登録する"
      expect(page).to have_current_path(stocks_path)
    end

    it "成功メッセージが表示されること" do
      click_button "教科書を登録する"
      expect(page).to have_content("在庫を追加しました")
    end
  end
end
