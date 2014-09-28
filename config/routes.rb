Rails.application.routes.draw do

  resources :orders
  resources :menus
  resources :api_tests
  resources :sampleusers

  resources :contacts, only: [:create]


  post 'place_order' => 'menus#place_order', as: :place_order

  # root 'orders#new'


  root 'navigation#coming_soon'

end