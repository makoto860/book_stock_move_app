require 'rails_helper'

RSpec.describe "stocks/", type: :system do
  let!(:stock) { create(:stock) }
  let!(:book) { create(:book) }
  let!(:location) { create(:location) }

  it "在庫一覧でタイトルが表示されること" do
    visit stocks_path
    expect(page).to have_content(stock.book.title)
    expect(page).to have_content(stock.location.name)
    expect(page).to have_content(stock.quantity)
    expect(page).to have_content(stock.created_at)
  end

  describe "在庫の登録画面" do
    before do
      visit new_stock_path
    end

    it "場所の入力欄が表示されること" do
      expect(page).to have_field("場所")
    end

    context "在庫の登録後のとき" do
      before do
        select book.title, from: "stock_book_id"
        select location.name, from: "stock_location_id"
        fill_in "stock_quantity", with: 1
        click_button "教科書を登録する"
      end

      it "教科書を登録するボタンを押すと在庫一覧画面に遷移すること" do
        expect(page).to have_current_path(stocks_path)
      end

      it "成功メッセージが表示されること" do
        expect(page).to have_content("在庫を登録しました")
      end
    end
  end
end
