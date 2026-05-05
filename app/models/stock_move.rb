class StockMove < ApplicationRecord
  belongs_to :book
  belongs_to :from_location, class_name: "Location", optional: true
  belongs_to :to_location, class_name: "Location", optional: true

  enum :move_type, {
    to_pick: 0,
    to_customer: 1,
    adjustment: 2
  }

  validates :quantity, presence: true
end
