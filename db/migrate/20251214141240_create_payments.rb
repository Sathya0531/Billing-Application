class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :bill, null: false, foreign_key: true
      t.float :amount_paid

      t.timestamps
    end
  end
end
