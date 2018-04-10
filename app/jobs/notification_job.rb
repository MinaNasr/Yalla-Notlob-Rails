class NotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end
  NotificationChannel.broadcast_to(
  current_user,
  title: 'New things!',
  body: 'All the news fit to print'
)
end
