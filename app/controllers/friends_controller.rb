class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :update, :destroy]

  # GET /friends
  def index
    #list only friend of authenticated user
    @friends = Friend.where(user_id:  $user_id)

    render json: @friends
  end

  # GET /friends/1
  def search 
    render json: @friend
  end

  # POST /friends
  def create
    @friend = Friend.new(friend_params)
    @friend.user_id = $user_id

    #check if user exits before add him to friend list
    render json: {} if User.find(friend_params[:friend_id]).nil?
    
    if @friend.save
      render json: {message:"success"}
    else
      render json: @friend.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /friends/1
  def update
    if @friend.update(friend_params)
      render json: @friend
    else
      render json: @friend.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friends/1
  def destroy
    @friend.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def friend_params
      params.require(:friend).permit(:friend_id)
    end
end
