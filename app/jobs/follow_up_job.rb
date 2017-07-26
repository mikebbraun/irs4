class FollowUpJob < ApplicationJob
  queue_as :email

  def perform(email, name)
    # Do something later
    UserMailer.follow_up(email, name).deliver_now
  end
end
