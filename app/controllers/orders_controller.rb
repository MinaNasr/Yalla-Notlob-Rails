class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
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
      @auth_user = User.find($user_id)

      #invaite friends to order
      puts json:  order_users_params[:users]
      order_users_params[:users].each do |order_user|

        if(@auth_user.friends.where(friend_id: order_user[:user_id]).length > 0 )
          @order_user = OrderUser.new(user_id: order_user[:user_id] ,order_id: @order.id)
          @invited_friends.push (User.find(order_user[:user_id]) )
          @order_user.save   
        end

      end

        #convert group to users if group
        order_users_params["groups"].each do |group|
          # @group = Group.find(group["group_id"])
          if(@auth_user.groups.where(id:group[:group_id]).length > 0)
              @group_details = GroupDetail.where(group_id: group[:group_id])
              #get all group memebers and add them to this order
              @group_details.each do |group_record|
                @invited_friends.push( group_record.user )
                @order_user = OrderUser.new(user_id: group_record.user.id ,order_id: @order.id)
                @order_user.save  
              end   
          end
        end

      render json: [order: @order,invited_friends: @invited_friends], status: :created, location: @order
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

  #method for list friends in specific order
  def list_members
    @order_users = OrderUser.where(order_id: params[:order_id])
    @users = [];
    @order_users.each do |order_user|
      @users.push(order_user.user)
      
    end
    
    if @users
      render json: @users
    else
      render json: @users.errors, status: :unprocessable_entity
    end
  end
  # list latest orders
  def latestOrders
    @order_users = OrderDetail.where(user_id: params[:user_id])
    @comments = [];
    @order_users.each do |order_user|
      @comments.push(order_user.comment)
      
    end
    render json: @comments
  end
  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
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
end
