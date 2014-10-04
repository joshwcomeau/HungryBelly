class OrderMailer < ActionMailer::Base
  default from: "hungrybellyapp@gmail.com"

  def send_order(order)
    @order = order
    mail(
      to: 'joshwcomeau@gmail.com',
      subject: 'New Order Placed'
    )
  end
end
