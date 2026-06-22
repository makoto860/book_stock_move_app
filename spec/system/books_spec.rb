require 'rails_helper'

RSpec.describe "books/", type: :system do
  let!(:book) { create(:book) }

  it "一覧画面にタイトルが表示されること" do
    visit books_path
    expect(page).to have_content(book.title)
  end

  it "新しく登録するリンクが表示されること" do
    visit books_path
    expect(page).to have_link("教科書を新しく登録する")
  end

  it "教科書を登録するボタンが表示されること" do
    visit new_book_path
    expect(page).to have_button("教科書を登録する")
  end

  it "タイトル入力欄が表示されること" do
    visit new_book_path
    expect(page).to have_field("タイトル")
  end

  it "教科書一覧に戻るをクリックすると一覧画面へ遷移すること" do
    visit new_book_path
    click_link "教科書一覧に戻る"
    expect(page).to have_current_path(books_path)
  end
end
