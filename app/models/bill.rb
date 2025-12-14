class Bill < ApplicationRecord
  has_many :bill_items
  has_one :payment

  validates :customer_email, presence: true
end