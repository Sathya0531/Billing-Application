class Product < ApplicationRecord
  validates :product_code, uniqueness: true
  validates :stock, :unit_price, :tax_percentage, presence: true
end
