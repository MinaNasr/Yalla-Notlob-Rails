class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]

  # GET /groups
  def index
    @groups = Group.all

    render json: @groups
  end

  # GET /groups/1
  def show
      render json: @group
  end

  # POST /groups
  def create

    @user=  User.find_by_id($user_id)

    @group = @user.groups.create(group_params)
   
    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def add_memeber
    #except validate user_id is already in user friends 
    @group_member = GroupDetail.new(group_member_params)

    if @group_member.save
      render json: @group_member, status: :created, location: @groups
    else
      render json: @group_member.errors, status: :unprocessable_entity
    end
  end

  def list_members

    @group_members = GroupDetail.where(group_id: params[:group_id])
    if @group_members
      render json: @group_members, status: :created, location: @groups
    else
      render json: @group_members.errors, status: :unprocessable_entity
    end
  end
  

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:groupName)   
    end

    def group_member_params
      params.require(:group).permit(:group_id,:user_id)
    end
end
