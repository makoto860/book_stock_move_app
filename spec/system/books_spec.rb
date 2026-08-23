require 'rails_helper'

RSpec.describe "books", type: :system do
  let!(:book) { create(:book) }

  context "教科書一覧画面で取り寄せではないとき" do
    let!(:book) do
      create(:book, special_order_date_time: nil, order_date_time: nil)
    end

    it "×が表示されること" do
      visit books_path
      expect(page).to have_content("×")
    end
  end
end
