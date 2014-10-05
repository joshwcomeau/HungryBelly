class OrdersController < ApplicationController
  def create    
    @order = Order.new(order_params)

    if params[:cuisines]
      params[:cuisines].each do |c|
        if c.last.last == "1"
          @order.cuisines << Cuisine.find_by(name: c.first)
        end
      end
    end

    if @order.save
      # OrderMailer.send_order(@order).deliver
      render :thank_you
    else

    end
  end

  private
  def order_params
    params.require(:order).permit(:first_name, :last_name, :phone, :email, :street, :city, :postal_code, :servings, :budget, :notes)
  end
end
