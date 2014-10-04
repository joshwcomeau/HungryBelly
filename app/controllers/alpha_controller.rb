class AlphaController < ApplicationController
  def new
    @order = Order.new    
    OrderMailer.send_order
    render layout: "alpha_application"
  end

end

