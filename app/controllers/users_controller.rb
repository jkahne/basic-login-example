class UsersController < ApplicationController
  before_action :authorize

  def index
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    RequestPasswordReset.new(@user, generate_password: true ).call
    if @user.save
      UserMailer.new_user(@user).deliver
      redirect_to overlord_users_path, notice: "User has been created!"
    else
      render :index
    end
  end

  def reset_password
    user = User.find(params[:id])
    RequestPasswordReset.new(user).call
    if user.save(context: :request_password_reset)
      UserMailer.send_password_reset(user).deliver
      redirect_to overlord_users_path, notice: "User password has been reset and an email sent!"
    else
      render :index
    end
  end

  private

  def new_user_params
    params.require(:user).permit(:email, :role)
  end

end
