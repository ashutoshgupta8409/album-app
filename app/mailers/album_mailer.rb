class AlbumMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject:"Successfully Created an Album")
  end
end
