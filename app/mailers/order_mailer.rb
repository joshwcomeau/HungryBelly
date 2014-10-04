class OrderMailer < ActionMailer::Base
  default from: "\"#paid\" <hello@hashtagpaid.com>"

  def send_order
    @order = { servings: 5, budget: 25 }
    mail(
      to: 'joshwcomeau@gmail.com',
      subject: 'New Order Placed'
    )
  end
end
