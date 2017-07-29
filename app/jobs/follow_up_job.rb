class FollowUpJob < ApplicationJob
  queue_as :email

  def perform(email, name)
    # Do something later
    UserMailer.follow_up(email, name).deliver
    p "<>"*20
    p "email sent"
  end
end
