class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "notifications_#{$user_id}"

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
