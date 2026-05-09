module BooksHelper
  # app/helpers/books_helper.rb
  def book_status_icon(book)
    if book.invalid_order_timing?
      content_tag(:span, "●", style: "color: #38bdf8;")
    else
      content_tag(:span, "×", style: "color: #94a3b8;")
    end
  end

  def book_table_style(book)
    if book.invalid_order_timing?
      "background-color: #00ffff; font-weight: bold;"
    end
  end
end
