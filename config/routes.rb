Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }
  resources :orders
  resources :menus
  resources :api_tests
  resources :contacts, only: [:create]


  post 'place_order' => 'menus#place_order', as: :place_order
  get 'alpha/order' => 'alpha#new', as: :alpha_path


  root 'navigation#coming_soon'

end