class Product < ApplicationRecord
  validates :product_code, uniqueness: true
  validates :stock, :unit_price, :tax_percentage, presence: true

  alias_attribute :available_stocks, :stock
end
