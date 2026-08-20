require "rails_helper"

RSpec.describe "books", type: :request do
  describe "PATCH /books/:idの編集画面" do
    let!(:book) { create(:book, title: "更新前タイトル") }

    it "タイトルを更新できること" do
      patch book_path(book),
      params: { book: { title: "更新後タイトル" } }
      expect(response).to have_http_status(:redirect)
      expect(book.reload.title).to eq("更新後タイトル")
    end
  end

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
      expect(response.body).to include(
        I18n.l(book.created_at, format: :datetime_jp)
      )
    end
  end

  describe "POST /booksの登録画面" do
    let(:params) do
      {
        book: {
          title: "テスト本",
          isbn: "9999999999999",
          rack_number: "A~Z"
        }
      }
    end

    it "教科書の情報１件を登録できること" do
      book = Book.new(params[:book])
      expect {
        book.save!
      }.to change(Book, :count).by(1)
    end
  end
end
