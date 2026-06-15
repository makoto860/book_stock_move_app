require "rails_helper"

RSpec.describe Book, type: :model do
  describe "validation" do
    it "titleが存在すると有効" do
      book = Book.new(
      title: "Ruby入門",
      rack_number: "A-1",
      isbn: "9781234567890"
      )
      expect(book).to be_valid
    end
  end
end
