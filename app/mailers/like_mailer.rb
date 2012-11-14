class LikeMailer < ActionMailer::Base
  default from: "ralph@friendskis.com",
          charset: "utf-8"

  def like_email(photo, user, liker)
    @photo = photo
    @user = user
    @liker = liker
    @url = "https://apps.facebook.com/friendskis"
    mail(:to => user.email, :subject => "Someone liked your photo on Friendskis!")
  end
end
