class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: [:show, :update, :destroy]

  # GET /order_details
  def index
    #no auth check
    @order_details = OrderDetail.where(order_id: params[:order_id])

    render json: @order_details
  end

  # GET /order_details/1
  def show
    render json: @order_detail
  end

  # POST /order_details
  def create
    #check if OrderUser for this order is exists
    if(OrderUser.where(order_id: order_detail_params[:order_id],
      user_id: order_detail_params[:user_id]).length > 0)
     
      @order_detail = OrderDetail.new(order_detail_params)

      if @order_detail.save
        render json: @order_detail, status: :created, location: @order_detail
      else
        render json: @order_detail.errors, status: :unprocessable_entity
      end
    else 
      render json: {message:"unauthorized"}
    end
    
  end

  # PATCH/PUT /order_details/1
  def update
    if @order_detail.update(order_detail_params)
      render json: @order_detail
    else
      render json: @order_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_details/1
  def destroy
    @order_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_detail
      @order_detail = OrderDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_detail_params
      params.require(:order_detail).permit(:order_id, :user_id, :comment, :item_name, :amount, :price)
    end
end
