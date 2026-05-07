class StockMove < ApplicationRecord
  belongs_to :book
  belongs_to :from_location, class_name: "Location"
  belongs_to :to_location, class_name: "Location"
end
