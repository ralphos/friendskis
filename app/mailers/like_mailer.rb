class LikeMailer < ActionMailer::Base
  default from: "ralph@friendskis.com",
          charset: "utf-8"

  def like_email(photo, liker)
    @photo = photo
    @liker = liker
    mail(:to => @photo.user.email, :subject => "Someone liked your photo on Friendskis!")
  end
end
