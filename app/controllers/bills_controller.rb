class BillsController < ApplicationController
  def new
    @bill = Bill.new
    @bill.bill_items.build
    @denominations = Denomination.order(:value)
  end

  def create
    @bill = Bill.new(bill_params)

    begin
      result = BillingCalculator.new(@bill, params[:bill_items], params[:denominations]).calculate

      if result[:success]
        @bill.assign_attributes(result[:bill_data])

        # Create bill items
        result[:bill_items_data].each do |item_data|
          @bill.bill_items.build(item_data)
        end

        @bill.save!
        redirect_to @bill
      else
        flash.now[:error] = result[:error]
        @denominations = Denomination.order(:value)
        render :new
      end
    rescue => e
      flash.now[:error] = e.message
      @denominations = Denomination.order(:value)
      render :new
    end
  end

  def show
    @bill = Bill.find(params[:id])
    @change_breakdown = calculate_change_breakdown(@bill.balance)
  end

  def index
    @bills = Bill.all.order(created_at: :desc)
  end

  private

  def bill_params
    params.require(:bill).permit(:customer_email, :amount_paid)
  end

  def calculate_change_breakdown(balance)
    return {} if balance <= 0

    denominations = Denomination.order(value: :desc)
    breakdown = {}
    remaining = balance.to_f

    denominations.each do |denom|
      if remaining >= denom.value && denom.count > 0
        notes_needed = (remaining / denom.value).to_i
        notes_available = [ notes_needed, denom.count ].min

        if notes_available > 0
          breakdown[denom.value] = notes_available
          remaining -= notes_available * denom.value
          remaining = remaining.round(2)
        end
      end
    end

    breakdown
  end
end
