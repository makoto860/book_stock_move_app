require "rails_helper"

RSpec.describe "Books Page", type: :request do
  describe "GET /books" do
    let!(:book) { create(:book, title: "title") }

    it "正常にレスポンスを返すこと" do
      get books_path
      expect(response).to have_http_status(:success)
    end

    it "タイトルが含まれること" do
      get books_path
      expect(response.body).to include(book.title)
    end
  end

  describe "POST /books" do
    let(:params) do
      { book: { title: "new_title", rack_number: "new_rack_number", isbn: "new_isbn"} }
    end

    it "本の情報を登録できること" do
      expect { post books_path, params: params }.to change(Book, :count).by(1)
    end
  end
end
