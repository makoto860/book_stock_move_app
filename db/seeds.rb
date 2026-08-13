# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.find_or_create_by!(email: "test@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end

warehouse = Location.find_or_create_by!(
  name: "倉庫",
  code: "WAREHOUSE",
  kind: :warehouse
)

pick = Location.find_or_create_by!(
  name: "PICK場",
  code: "PICK",
  kind: :pick
)

customer = Location.find_or_create_by!(
  name: "お客さん",
  code: "CUSTOMER",
  kind: :customer
)

books = 3000.times.map do |i|
  {
    title: "テスト本#{i + 1}",
    isbn: "978400000#{i.to_s}",
    rack_number: "棚番号",
    created_at: Time.current,
    updated_at: Time.current
  }
end
Book.insert_all(books)

stock_moves = 500.times.map do |i|
  {
    book_id: (i % 3000) + 1,
    from_location_id: i.even? ? 1 : 2,
    to_location_id: i.even? ? 2 : 3,
    quantity: rand(1..10),
    move_type: i.even? ? "移動1" : "移動2",
    created_at: Time.current,
    updated_at: Time.current
  }
end
StockMove.insert_all(stock_moves)

stocks = 3000.times.map do |i|
  {
    book_id: (i % 3000) + 1,
    location_id: i.even? ? 1 : 2,
    quantity: rand(1..10),
    created_at: Time.current,
    updated_at: Time.current
  }
end
Stock.insert_all(stocks)
