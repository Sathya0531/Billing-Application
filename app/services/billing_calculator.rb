class BillingCalculator
  def initialize(bill, bill_items_params, denominations_params)
    @bill = bill
    @bill_items_params = bill_items_params || {}
    @denominations_params = denominations_params || {}
  end

  def calculate
    return { success: false, error: "No items provided" } if @bill_items_params.empty?

    total_price = 0
    total_tax = 0
    bill_items_data = []

    @bill_items_params.each do |_, item_params|
      next if item_params[:product_code].blank? || item_params[:quantity].blank?

      product = Product.find_by(product_code: item_params[:product_code])
      return { success: false, error: "Product #{item_params[:product_code]} not found" } unless product

      quantity = item_params[:quantity].to_i
      return { success: false, error: "Invalid quantity for #{product.product_code}" } if quantity <= 0
      return { success: false, error: "Insufficient stock for #{product.product_code}" } if quantity > product.stock

      purchase_price = product.unit_price * quantity
      tax_amount = purchase_price * product.tax_percentage / 100
      item_total = purchase_price + tax_amount

      bill_items_data << {
        product: product,
        quantity: quantity,
        unit_price: product.unit_price,
        tax_amount: tax_amount,
        total_price: item_total
      }

      total_price += purchase_price
      total_tax += tax_amount

      # Reduce stock
      product.update!(stock: product.stock - quantity)
    end

    # Calculate amount paid from denominations
    amount_paid = calculate_amount_paid

    net_price = total_price + total_tax
    rounded_price = net_price.floor
    balance = amount_paid - rounded_price

    {
      success: true,
      bill_data: {
        total_price: total_price,
        total_tax: total_tax,
        net_price: net_price,
        rounded_price: rounded_price,
        amount_paid: amount_paid,
        balance: balance
      },
      bill_items_data: bill_items_data
    }
  end

  private

  def calculate_amount_paid
    total = 0
    @denominations_params.each do |denom_id, count|
      next if count.blank? || count.to_i <= 0

      denomination = Denomination.find(denom_id)
      total += denomination.value * count.to_i
    end
    total
  end
end
