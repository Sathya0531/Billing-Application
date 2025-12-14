# seeding Denominations
[ 500, 50, 20, 10, 5, 2, 1 ].each do |v|
  Denomination.create!(value: v, count: 100)
end

# seeding Products
Product.create!(name: "Laptop", product_code: "LP001", stock: 10, unit_price: 50000.0, tax_percentage: 18.0)
Product.create!(name: "Mouse", product_code: "MS001", stock: 50, unit_price: 500.0, tax_percentage: 12.0)
Product.create!(name: "Keyboard", product_code: "KB001", stock: 30, unit_price: 1500.0, tax_percentage: 12.0)
