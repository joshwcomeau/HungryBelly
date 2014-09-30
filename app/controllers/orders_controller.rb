class OrdersController < ApplicationController
  def create    
    @order = Order.new(order_params)
  end

  private
  def order_params
    params.require(:order).permit(:first_name, :last_name, :phone, :email, :street, :city, :postal_code, :servings, :budget, :notes)
  end
end
