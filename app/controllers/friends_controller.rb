class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :update, :destroy]

  # GET /friends
  def index
    #list only friend of authenticated user
    @friends = Friend.where(user_id:  $user_id)
    puts json:@friends
    @users  = [];

    
    @friends.each do |friend|
      @users.push( User.where(id: friend.friend_id) )
    end
    
    render json: @users
  end

  # GET /friends/1
  def search 
    render json: @friend
  end

  # POST /friends
  def create
    @user  = User.find_by_email(params[:email])
    puts @user.nil?
    if @user.nil? == true
      puts 333
      render json: {message:"not found"}
      return 
    end

      @friend = Friend.new(friend_id: @user[:id])
      @friend.user_id = $user_id

      #check if user exits before add him to friend list      
      if @friend.save
        render json: {message:"success"}
      else
        render json:{message:"fail"}
   
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

  def delete
    puts $user_id
    puts params[:id]
      puts json: Friend.where(friend_id: params[:id],user_id: $user_id)
    if  Friend.where(friend_id: params[:id],user_id: $user_id).delete_all
     render json:  {message:"success"}
    else
      render json: {message:"failed"}
    end
  end

  # latest activities of a certain user

  def latestActivities
    @friends = Friend.all.where(user_id: $user_id)
    @friends_activities = [];
    @friends.each do |friend|
      @friend_activities = {};
      name = (User.select("name").where(id: friend.friend_id))
      @friend_activities[:freind_name]=name
      @friend_orders=Order.select("meal_name","restaurant_name","status","created_at").where(user_id: friend.friend_id).limit(2).order("created_at Desc")
      @friend_activities[:friend_orders]=@friend_orders
      @friends_activities.push @friend_orders
    end
    if @friends_activities
      # render :json => {:friends_activities => @friends_activities}
      render json: @friends_activities
    else
      render json: @friends_activities.errors, status: :unprocessable_entity
    end
  end    
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def friend_params
      params.require(:friend).permit(:email)
    end
end
