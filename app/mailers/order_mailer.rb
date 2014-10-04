class OrderMailer < ActionMailer::Base
  default from: "HungryBelly <#{ENV['SENDGRID_USERNAME']}>"

  def send_order(order)
    @order = order
    mail(
      to: 'miss.ellenlai@gmail.com',
      subject: 'New Order Placed'
    )
  end
end
