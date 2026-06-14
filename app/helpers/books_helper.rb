module BooksHelper
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

  def format_special_order_date_time(book)
    book.special_order_date_time ? l(book.special_order_date_time, format: :datetime_jp) :"×"
  end

  def format_order_date_time(book)
    book.order_date_time ? l(book.order_date_time, format: :datetime_jp) :"×"
  end
end
