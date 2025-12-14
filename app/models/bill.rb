class Bill < ApplicationRecord
  has_many :bill_items, dependent: :destroy
  has_one :payment

  accepts_nested_attributes_for :bill_items

  validates :customer_email, presence: true
end
