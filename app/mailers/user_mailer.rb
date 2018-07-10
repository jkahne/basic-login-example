class UserMailer < ApplicationMailer
  default from: ENV["USER_NOTIFIER_FROM_ADDRESS"]

  def new_user(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome!')
  end

  def send_password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Password Reset" )
  end
end
