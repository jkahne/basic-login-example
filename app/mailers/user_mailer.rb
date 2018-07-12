class UserMailer < ApplicationMailer
  default from: ENV["user_notifier_from_address"]

  def new_user(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Go iLawn!')
  end

  def send_password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Go iLawn Password Reset" )
  end
end
