class CustomNotificationsController < ApplicationController
  def index
    @notifications = @target.notifications
    render json: @notifications
  end
end
