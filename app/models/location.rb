class Location < ApplicationRecord
  has_many :stocks
  enum :kind, {
    warehouse: 0,
    pick: 1,
    customer: 2,
  }, prefix: true

  def self.warehouse
    find_by!(kind: :warehouse)
  end

  def self.pick
    find_by!(kind: :pick)
  end

  def self.customer
    find_by!(kind: :customer)
  end
end
