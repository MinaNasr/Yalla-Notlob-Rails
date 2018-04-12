class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.where(user_id: $user_id)
    # puts json: @orders
    @joined_members = [];
    @invited_friends =[];

    
    @orders.each do |order|
      # @orders[index].attributes.merge(:ss => "dd") 
      # {@orders[index] =>  @orders[index].attributes.merge( :oooooooo => 55 )}
      # render json: { ad:  @orders[index].attributes.merge( :oooooooo => 555)} 

      # puts json: @orders[index]

      @joined_members.push(OrderUser.where(order_id: order[:id] , join: true).select(:id).count)
      @invited_friends.push(OrderUser.where(order_id: order[:id] ).select(:id).count)
    end
    
    
    
    render json: [@orders, "joined" => @joined_members,"invited" => @invited_friends]
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  # done except for add image
  #create order with friends/groups
  def create
    @order = Order.new(order_params)
    @order.user_id = $user_id    
 

    #validate user_id includes in friend_list of user #not yet

    #add user to order_users

    if @order.save
      # @order_users.order_id = @order.id
      @invited_friends  = []
      @auth_user = User.find_by_id($user_id)

      #invaite friends to order
      puts json:  order_users_params[:users]
      order_users_params[:users].each do |order_user|

        if(@auth_user.friends.where(friend_id: order_user[:user_id]).length > 0 )
          @order_user = OrderUser.new(user_id: order_user[:user_id] ,order_id: @order.id)
          @invited_friends.push (User.find(order_user[:user_id]) )
          @order_user.save   
          puts 33333333333
          @notif = Notification.create(user_id: order_user[:user_id], notif_type: "invite", 
                              order_finished: false, order_id: @order[:id],
                              name: @auth_user.name, viewed: false)
          p @notif
          if @notif.save
              ActionCable.server.broadcast "notifications_#{friend}",{
                  notif_type: "invite",
                  order_id: @order[:id],
                  name: @auth_user.name
              }                       
              
          end
        end

      end

      #optimize this query
      @all_users = User.all
      @all_users.each { |u|
        #send notif to all users that has order owner as a friend 
          if  Friend.where(user_id: u[:id] , friend_id: $user_id).length > 0
                  ActionCable.server.broadcast "activities_#{u.id}",{
                  order_id: @order[:id],
                  name: @auth_user.name,
                  restaurant: @order.restaurant_name,
                  } 
          end
      }

      render json: {message:"success"} #[order: @order,invited_friends: @invited_friends], status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end


  def remove_friend

    #check auth user friend
    @auth_user = User.find($user_id)

    if(@auth_user.orders.where(id: order_remove_user_params["order_id"]).length > 0 )
        @order_friend = OrderUser.where(order_id: order_remove_user_params["order_id"],
          user_id:  order_remove_user_params["friend_id"] ).destroy_all
        if @order_friend 
          render json: {message: "success"}
        else
          render json: {message:"error"}
        end
    else
      render json: {message:"unauthorized"}
    end
  end



  # list latest orders
  def latestOrders
    @order_users = Order.select("meal_name","created_at").where(user_id: $user_id)
    @meal_names = [];
    @meal_times = [];
    @order_users.each do |order_user|
      @meal_names.push(order_user.meal_name)
      @meal_times.push(order_user.created_at)
    end
    if @meal_names
      render :json => {:meal_names => @meal_names,:meal_times => @meal_times}
    else
      render json: @meal_names.errors, status: :unprocessable_entity
    end
  end

  def change_status
    @order =Order.find(change_status_params[:order_id])

    if @order.update_column(:status, change_status_params[:status]) 
      @orders = Order.where(user_id: $user_id)
      @joined_members = [];
      @invited_friends =[];
      
      @orders.each do |order|
        @joined_members.push(OrderUser.where(order_id: order[:id] , join: true).select(:id).count)
        @invited_friends.push(OrderUser.where(order_id: order[:id] ).select(:id).count)
      end
      
      render json: [@orders, "joined" => @joined_members,"invited" => @invited_friends]
    else
      render json: {message:"failed"}
    end
  end
  
  # PATCH/PUT /orders/1
  def update
    puts params[:status]

    if @order.update(params[:status])
      if @order.update_column(:status, params[:status]) 
        render json: {orders: Order.where(user_id: $user_id)}
      else
        render json: {message:"failed"}
      end
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  def get_invited
    @invited_friends  = OrderUser.where(order_id: params[:order_id])
    render json: @invited_friends,include: 'user'
    
  end

  def get_joined
    @joined_friends  = OrderUser.where(order_id: params[:order_id],join: true)
    render json: @joined_friends,include: 'user'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:meal_name, :image ,:restaurant_name) #.require(:order)
    end

    def order_users_params
      #seprate array of user ids and array of group ids
      params.permit(users: [:user_id],groups: [:group_id]) #.require(:order)
    end

    def order_remove_user_params
      params.permit(:order_id,:friend_id)
    end

    def change_status_params
      params.permit(:order_id,:status)
    end
end
