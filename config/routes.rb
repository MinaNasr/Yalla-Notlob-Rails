Rails.application.routes.draw do

  # mount Notifications::Engine => "/notifications"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  # action cable server URI
  mount ActionCable.server => '/cable'
  
  # get all notifications for a user
  get 'users/:user_id/notifications', to: 'notifications#get_all_notifications'

  get 'groups/members', to:'groups#list_members'
  post 'groups/add', to: 'groups#add_memeber'
  post 'groups/remove', to:'groups#remove_memeber'

  post 'orders/remove_friend', to: 'orders#remove_friend'
  get 'orders/list', to: 'orders#list_members'
  post 'orders/change_status', to:'orders#change_status'
  get 'orders/latestOrders', to:'orders#latestOrders'
  
  get 'orders/invited', to: 'orders#get_invited'
  get 'orders/joined', to: 'orders#get_joined'

  get 'friends/latestActivities', to:'friends#latestActivities'

  # post 'orders/invite_friend', to: 'orders#invite_friend'


  
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'users/auth', to: 'users#get_data'
  post 'users/search', to: 'users#search'
  post 'users/join_order', to: 'users#join_order' 
  post 'friends/delete', to:'friends#delete'

  resources :friends
  resources :order_details
  resources :orders
  resources :users
  # resources :group_details
  resources :groups
  # mounting action cable server
  mount ActionCable.server => '/cable'

end
