require "rails_helper"

RSpec.describe "Books Page", type: :request do
  describe "GET /books" do
    it "正常にレスポンスを返すこと" do
      get books_path

      puts "STATUS: #{response.status}"
      puts response.body

      expect(response).to have_http_status(:success)
    end
  end
end
