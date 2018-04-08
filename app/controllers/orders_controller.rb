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
  # done except for add friends/groups
  def create
    @order = Order.new(order_params)
    @order.user_id = $user_id    
    #convert group to users if group #not yet
    #validate user_id includes in friend_list of user #not yet

    #add user to order_users

    if @order.save
      # @order_users.order_id = @order.id
      puts order_users_params["users"]
      
      #invaite friends to order
      order_users_params["users"].each do |order_user|
        @order_user = OrderUser.new(user_id: order_user["user_id"] ,order_id: @order.id)
        @order_user.save   
      end

      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
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
      params.permit(users: [:user_id]) #.require(:order)
    end
end
