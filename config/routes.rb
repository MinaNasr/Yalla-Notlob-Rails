Rails.application.routes.draw do

  # mount Notifications::Engine => "/notifications"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  get 'groups/members', to:'groups#list_members'
  post 'groups/add', to: 'groups#add_memeber'
  post 'groups/remove', to:'groups#remove_memeber'
  
  post 'orders/remove_friend', to: 'orders#remove_friend'
  get 'orders/list', to: 'orders#list_members'
  post 'orders/change_status', to:'orders#change_status'

  # post 'orders/invite_friend', to: 'orders#invite_friend'


  
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  post 'users/search', to: 'users#search'
  post 'users/join_order', to: 'users#join_order' 

  resources :friends
  resources :order_details
  resources :orders
  resources :users
  # resources :group_details
  resources :groups

end
