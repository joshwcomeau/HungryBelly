class OrderMailer < ActionMailer::Base
  default from: ENV['SENDGRID_USERNAME']

  def send_order(order)
    @order = order
    mail(
      to: 'twoequalsone@live.com',
      subject: 'New Order Placed'
    )
  end
end
