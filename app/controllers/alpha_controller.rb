class AlphaController < ApplicationController
  def new
    @order = Order.new    
    OrderMailer::send_order(
      name: 'james',
      thing1: 'woohoo!'
    )
    render layout: "alpha_application"
  end

end

