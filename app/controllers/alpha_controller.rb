class AlphaController < ApplicationController
  def new
    @order = Order.new
    render layout: "alpha_application"
  end

  def create

  end
end

