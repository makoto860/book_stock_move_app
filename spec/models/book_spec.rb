# spec/models/book_spec.rb
require "rails_helper"

RSpec.describe Book, type: :model do
  describe "validation" do
    let!(:book) { create(:book) }

    it "titleが存在すると有効" do
      expect(book).to be_valid
    end
  end
end
