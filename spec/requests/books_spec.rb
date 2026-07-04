require "rails_helper"

RSpec.describe "Books Page", type: :request do
  describe "GET /booksの一覧画面" do
    let!(:book) { create(:book) }

    it "正常にレスポンスを返すこと" do
      get books_path
      expect(response).to have_http_status(:success)
    end

    it "bookデータが含まれること" do
      get books_path
      expect(response.body).to include(book.title)
      expect(response.body).to include(book.rack_number)
      expect(response.body).to include(book.isbn)
    end
  end

  describe "POST /booksの新規登録画面" do
    let(:params) do
      { book: { title: "new_title", rack_number: "new_rack_number", isbn: "new_isbn"} }
    end

    it "本の情報を登録できること" do
      expect { post books_path, params: params }.to change(Book, :count).by(1)
    end
  end

  describe "PATCH /books/:idの編集画面" do
    let!(:book) { create(:book, title: "更新前タイトル") }

    it "タイトルを更新できること" do
      patch book_path(book), params: { book: { title: "更新後タイトル" } }
      expect(book.reload.title).to eq("更新後タイトル")
    end
  end

  describe "DELETE /books/:idの削除の画面" do
    let!(:book) { create(:book) }

    it "本を削除できること" do
      expect { delete book_path(book) }.to change(Book, :count).by(-1)
    end
  end
end
