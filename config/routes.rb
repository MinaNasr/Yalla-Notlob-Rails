Rails.application.routes.draw do
  resources :order_details
  resources :orders
  resources :users
  resources :group_details
  resources :groups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
