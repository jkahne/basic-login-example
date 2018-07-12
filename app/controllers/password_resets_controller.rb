class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    RequestPasswordReset.new(user).call
    if user.save(context: :request_password_reset)
      UserMailer.send_password_reset(user).deliver
      redirect_to login_path, notice: "An email has been sent to #{params[:email]} with password reset instructions."
    else
      flash.now.alert = user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token(params[:id])
    if @user.update_attributes(reset_password_params)
      session[:user_id] = @user.id
      flash.now.notice = "Your password has been reset!"
      redirect_to "/map#/dashboard"
    else
      flash.now.alert = "Invalid Password."
      render :edit
    end
  end

  private

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
