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

  context "取り寄せのとき" do
    let!(:book) do
      create(:book, special_order_date_time: Time.current, order_date_time: 1.day.from_now)
    end

    it "教科書一覧画面でありが表示されること" do
      visit books_path
      expect(page).to have_content("あり")
    end

    it "教科書の情報画面で背景色が変更されること" do
      visit book_path(book)
      expect(page).to have_css("table[style='background-color: #00ffff;']")
    end
  end

  it "一覧画面にbookデータが表示されること" do
    visit books_path
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.rack_number)
    expect(page).to have_content(book.isbn)
  end

  it "新しく登録するリンクが表示されること" do
    visit books_path
    expect(page).to have_link("教科書を新しく登録する")
  end

  it "教科書を登録するボタンが表示されること" do
    visit new_book_path
    expect(page).to have_button("教科書を登録する")
  end

  it "入力欄が表示されること" do
    visit new_book_path
    expect(page).to have_field("タイトル")
    expect(page).to have_field("棚の番号")
    expect(page).to have_field("ISBN")
    expect(page).to have_field("備考欄")
    expect(page).to have_field("取り寄せ日時")
    expect(page).to have_field("注文日時")
  end

  it "教科書一覧に戻るをクリックすると一覧画面へ遷移すること" do
    visit new_book_path
    click_link "教科書一覧に戻る"
    expect(page).to have_current_path(books_path)
  end

  it "教科書の情報画面にbookデータが表示されること" do
    visit book_path(book)
    expect(page).to have_content(book.id)
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.rack_number)
    expect(page).to have_content(book.isbn)
    expect(page).to have_content(book.note)
  end

  it "教科書一覧リンクが表示されること" do
    visit book_path(book)
    expect(page).to have_link("教科書一覧")
  end

  it "教科書の編集を完了するボタンが表示されること" do
    visit edit_book_path(book)
    expect(page).to have_button("教科書の編集を完了する")
  end

  it "タイトル入力欄が表示されること" do
    visit edit_book_path(book)
    expect(page).to have_field("タイトル")
    expect(page).to have_field("棚の番号")
    expect(page).to have_field("ISBN")
    expect(page).to have_field("備考欄")
    expect(page).to have_field("取り寄せ日時")
    expect(page).to have_field("注文日時")
  end

  it "ISBN読み取り画面が表示されること" do
    visit books_scanner_path
    expect(page).to have_content("ISBN読み取り画面")
  end

  it "CSSが表示されること" do
    visit books_scanner_path
    expect(page).to have_css("#reader")
    expect(page).to have_css("#result")
  end
end
