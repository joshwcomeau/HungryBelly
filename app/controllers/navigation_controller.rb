class NavigationController < ApplicationController

  def index
  
  end

  def coming_soon
    @email = Contact.new
  end
end
