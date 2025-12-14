class InvoiceMailerJob < ApplicationJob
  queue_as :default

  def perform(bill_id)
    bill = Bill.find(bill_id)
    InvoiceMailer.send_invoice(bill).deliver_now
  end
end
