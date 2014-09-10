Rails.application.routes.draw do

  resources :orders
  resources :menus
  resources :api_tests



  post 'place_order' => 'menus#place_order', as: :place_order

  # root 'orders#new'
  
  # Splash page. Uncomment when such a page exists.
  root 'navigation#index'
  
end