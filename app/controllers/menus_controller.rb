class MenusController < ApplicationController
  require 'ordrin'

  before_action :setup_api, only: [ :create ]

  def create

    # Build Address object.
    zip = params[:zip]
    addr = params[:street]

    if zip =~ /(^[\d]{5}$|^[\d]{5}\-[\d]{4}$)/
      city = zip.to_region(:city => true)
      state = zip.to_region(:state => true)
      address = {
        datetime: 'ASAP',
        addr:     addr,
        city:     city,
        zip:      zip
      }

      # Get order info from params
      cuisines = params["cuisines"]
      budget_low = params["lower"].to_i
      budget_high = params["upper"].to_i
      servings = params["servings"].to_i
    end
    

    if city.nil?
      @error = { 
        error_id: 1,
        message: "Sorry! We don't have any restaurants in our database that deliver to your area."
      }
    else
      @valid_restaurants = find_valid_restaurants(address, cuisines, budget_low)

      # Check if @restaurant found a valid restaurant
      if @valid_restaurants.is_a? Symbol
        if @valid_restaurants == :no_restaurants
          @error = { 
            error_id: 1,
            message: "Sorry! We don't have any restaurants in our database that deliver to your area."
          }
        elsif @valid_restaurants == :no_valid_restaurants
          @error = { 
            error_id: 2,
            message: "We found restaurants in your area, but you need to broaden your criteria. Please choose more cuisines or raise your budget."
          }
        end
      else
        
        3.times do 
          @restaurant = find_restaurant(@valid_restaurants)

          @order = build_order(@restaurant["menu"], budget_low, budget_high, servings)
          if @order != :no_possibilities
            break
          end
        end

        if @order == :no_possibilities
          @error = { 
            error_id: 3,
            message: "We can't seem to find a meal with that many servings. Please change budget, cuisines or servings"
          }
        end
      end
    end

    if @error
      render :json => @error
    else
      render :json => @order
    end
    

   


    

    # render :json => order_args

  end

  def build_order(restaurant, budget_low, budget_high, servings)
    possibilities = recursive_menu_gen(restaurant, [], budget_low, budget_high)
    if possibilities.length < servings
      return :no_possibilities
    else
      return possibilities.sample(servings)
    end
  end

  def build_tray(orders)
    tray = []
    orders.each do |o|
      tray << "#{o[:id]}/1"
    end
    tray.join(",+")
  end

  def recursive_menu_gen(r_object, keepers, budget_low, budget_high)
    # Make sure we don't keep max_child_select.
    
    r_object.each do |r_key, r_value|
      r_value = r_key if r_object.is_a? Array
      if r_value.class == Hash || r_value.class == Array
        recursive_menu_gen(r_value, keepers, budget_low, budget_high)
      elsif r_key == 'price' && r_value.to_f >= budget_low && r_value.to_f <= budget_high
        new_obj = {
          id: r_object["id"],
          price: r_object["price"],
          name: r_object["name"],
          descrip: r_object["descrip"]
        }
        keepers << new_obj
      end
    end
    keepers
  end


# The tray is composed of menu items and optional sub-items. A single menu item's format is: 
# [menu item id]/[qty],[option id],[option id]... Multiple menu items are joined by a +: 
# [menu item id]/[qty]+[menu item id2]/[qty2] For example: 3270/2+3263/1,3279 Means 2 of menu item 3270 
# (with no sub options) and 1 of item num 3263 with sub option 3279.

  def find_valid_restaurants(address, cuisines, budget_low)
    # Get a list of all restaurants that deliver to this address from the API
    @all_restaurants = @api.delivery_list(address)

    return :no_restaurants if @all_restaurants.count == 0
      
    # Filter down to the valid restaurants for this purpose
    @valid_restaurants = get_valid_restaurants(@all_restaurants, cuisines, budget_low)  

    return :no_valid_restaurants if @valid_restaurants.count == 0

    @valid_restaurants
  end

  def find_restaurant(restaurants)
    # Grab a random validated restaurant!
    @chosen_restaurant = restaurants.sample


    # Get restaurant info from API
    r_object = {
      rid: @chosen_restaurant['id'].to_s
    }
    
    # Return restaurant
    @api.restaurant_details(r_object)
  end


  private
  
  def get_valid_restaurants(rest, cuisines, budget_low)
    rest.select do |r|
      ( 
        ( r["services"]["deliver"]["can"] == 1 ) &&
        ( r["services"]["deliver"]["time"] < 60 ) && 
        ( r["services"]["deliver"]["mino"] <= budget_low ) && 
        ( cuisines.any? { |cuisine| r["cu"].include? cuisine } if r["cu"] ) 
      )
    end
  end

  def setup_api
    @api = Ordrin::APIs.new('NeDTpROHKr0wT6V0pYsdjmxxvKpazxe1W7jg4Pt02PQ', :test)
  end


end
