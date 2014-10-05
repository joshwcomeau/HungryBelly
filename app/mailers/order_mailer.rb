class OrderMailer < ActionMailer::Base
  default from: "HungryBelly <#{ENV['SENDGRID_USERNAME']}>"

  def send_order(order)
    @order = order
    mail(
      to: 'miss.ellenlai@gmail.com, joseplatero@gmail.com, joshwcomeau@gmail.com',
      subject: "HungryBelly Order ##{@order.id}"
    )
  end
end
