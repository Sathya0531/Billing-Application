class CreateBills < ActiveRecord::Migration[8.1]
  def change
    create_table :bills do |t|
      t.string :customer_email
      t.float :total_price
      t.float :total_tax
      t.float :net_price
      t.float :rounded_price
      t.float :amount_paid
      t.float :balance

      t.timestamps
    end
  end
end
