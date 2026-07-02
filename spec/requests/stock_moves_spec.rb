require "rails_helper"

RSpec.describe "StockMoves", type: :request do
  describe "GET /stock_movesの一覧画面" do
    let!(:stock_move) { create(:stock_move) }

    it "正常にレスポンスを返すこと" do
      get stock_moves_path
      expect(response).to have_http_status(:success)
    end

    it "教科書名が表示されること" do
      get stock_moves_path
      expect(response.body).to include(stock_move.book.title)
    end

    it "移動元が表示されること" do
      get stock_moves_path
      expect(response.body).to include(stock_move.from_location.name)
    end

    it "移動先が表示されること" do
      get stock_moves_path
      expect(response.body).to include(stock_move.to_location.name)
    end
  end

  describe "POST /stock_movesの履歴登録画面" do
    let!(:stock_move) { create(:stock_move) }
    let!(:book) { create(:book) }
    let!(:from_location) { create(:location, :warehouse) }
    let!(:to_location) { create(:location, :pick) }
    let!(:from_stock) do
      create(:stock, book: book, location: from_location, quantity: 10)
    end

    it "移動履歴が1件登録されること" do
      expect do
        post stock_moves_path, params: {
          stock_move: { book_id: book.id, from_location_id: from_location.id, to_location_id: to_location.id, quantity: 1, move_type: "移動" }
        }
      end.to change(StockMove, :count).by(1)
    end

    it "在庫一覧画面に遷移すること" do
      post stock_moves_path, params: {
        stock_move: { book_id: book.id, from_location_id: from_location.id, to_location_id: to_location.id, quantity: 1, move_type: "移動" }
      }
      expect(response).to redirect_to(stock_moves_path)
    end
  end

  describe "GET /stock_moves/confirmの確認画面" do
    let!(:book) { create(:book) }
    let!(:from_location) { create(:location, :warehouse) }
    let!(:to_location) { create(:location, :pick) }

    it "確認画面が含まれること" do
      get confirm_stock_moves_path, params: {
        stock_move: { book_id: book.id, from_location_id: from_location.id, to_location_id: to_location.id, quantity: 1, move_type: "移動" }
      }
      expect(response.body).to include("在庫移動履歴の確認画面")
    end
  end
end
