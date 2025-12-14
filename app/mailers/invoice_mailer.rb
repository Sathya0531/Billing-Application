class InvoiceMailer < ApplicationMailer
  default from: "billing@example.com"

  def send_invoice(bill)
    @bill = bill
    mail(to: @bill.customer_email, subject: "Your Invoice")
  end
end
