class AlphaController < ApplicationController
  before_action :authenticate_user!
  def new  
    @order = Order.new
    render layout: "alpha_application"

  end

  def closed
    render "orders/closed"
  end

end

