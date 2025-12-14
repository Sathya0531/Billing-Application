class BillItem < ApplicationRecord
  belongs_to :bill
  belongs_to :product

  attr_accessor :product_code
end
