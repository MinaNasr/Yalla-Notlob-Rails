Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :order_details
  resources :orders
  resources :users
  resources :group_details
  resources :groups
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'test', to: 'users#test'
  get 'posts/test', to: 'posts#test'
end
