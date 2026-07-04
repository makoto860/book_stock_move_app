require "rails_helper"

RSpec.describe "stocks", type: :request do
  describe "GET /stocks" do
    let!(:stock) { create(:stock) }

    it "正常にレスポンスを返すこと" do
      get stocks_path
      expect(response).to have_http_status(:success)
    end

    it "教科書の在庫データが含まれること" do
      get stocks_path
      expect(response.body).to include(stock.book.title)
      expect(response.body).to include(stock.location.name)
      expect(response.body).to include(stock.quantity.to_s)
      expect(response.body).to include(
        I18n.l(stock.created_at, format: :datetime_jp)
      )
    end
  end

  describe "POST /stocks" do
    context "新規の在庫を登録するとき" do
      let!(:book) { create(:book) }
      let!(:location) { create(:location) }

      it "在庫が新しく登録されること" do
        expect do
          post stocks_path, params: {
            stock: { book_id: book.id, location_id: location.id, quantity: 10 }
          }
        end.to change(Stock, :count).by(1)
      end
    end

    context "すでに在庫が存在するとき" do
      let!(:book) { create(:book) }
      let!(:location) { create(:location) }

      let!(:stock) do
        create(:stock, book: book, location: location, quantity: 5)
      end

      it "在庫数が加算されること" do
        expect do
          post stocks_path, params: {
            stock: { book_id: book.id, location_id: location.id, quantity: 3 }
          }
        end.not_to change(Stock, :count)
        expect(stock.reload.quantity).to eq(8)
      end
    end
  end
end
