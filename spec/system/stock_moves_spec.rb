require 'rails_helper'

RSpec.describe "stock_moves", type: :system do
  describe "在庫移動履歴を登録する画面" do
    before do
      visit new_stock_move_path
    end

    it "教科書を選択できること" do
      expect(page).to have_select("stock_move_book_id")
    end
  end
end
