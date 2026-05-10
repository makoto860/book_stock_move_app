module BooksHelper
  # app/helpers/books_helper.rb
  def book_status_icon(book)
    if book.invalid_order_timing?
      content_tag(:span, "あり", style: "color: #38bdf8;" "font-weight: bold;")
    else
      content_tag(:span, "×")
    end
  end

  def book_table_style(book)
    if book.invalid_order_timing?
      "background-color: #00ffff;"
    end
  end
end
