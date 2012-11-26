class MessageMailer < ActionMailer::Base
  default from: "ralph@friendskis.com",
          charset: "utf-8"

  def message_notification(message, user_id, sender)
    @message = message
    @user = User.find(user_id)
    @sender = sender
    @url = "https://apps.facebook.com/friendskis"
    mail(:to => @user.email, :subject => "You've got a new message!")
  end
end
