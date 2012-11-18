class SubscriptionMailer < ActionMailer::Base
  default from: "ralph@friendskis.com",
          charset: "utf-8"

  def subscription_email(user)
    @user = user
    mail(:to => "ralph@friendskis.com", :subject => "CHA-CHING!")
  end
end
