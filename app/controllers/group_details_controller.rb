class GroupDetailsController < ApplicationController
  before_action :set_group_detail, only: [:show, :update, :destroy]

  # GET /group_details
  def index
    @group_details = GroupDetail.all

    render json: @group_details
  end

  # GET /group_details/1
  def show
    render json: @group_detail
  end

  # POST /group_details
  def create
    @group_detail = GroupDetail.new(group_detail_params)

    if @group_detail.save
      render json: @group_detail, status: :created, location: @group_detail
    else
      render json: @group_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_details/1
  def update
    if @group_detail.update(group_detail_params)
      render json: @group_detail
    else
      render json: @group_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_details/1
  def destroy
    @group_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_detail
      @group_detail = GroupDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_detail_params
      params.require(:group_detail).permit(:groupId, :userId)
    end
end
