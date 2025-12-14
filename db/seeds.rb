# seeding Denominations
[500, 50, 20, 10, 5, 2, 1].each do |v|
  Denomination.create!(value: v, count: 100)
end
