class Notification < ApplicationRecord
  belongs_to :user

  def self.broadcast(user_id, message,url)
    notification = Notification.new(user_id: user_id ,message: message,  url: url, date: DateTime.now.localtime("-04:00"))
    notification.save!
    ActionCable.server.broadcast "notification_channel_#{user_id}",  notification: notification
  end
end
