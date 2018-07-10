class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to welcome_path
    end
  end

  def create
    user = User.where(email: params[:email], active: true).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash.now.notice = "Logged in!"
      redirect_to welcome_path
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil

    respond_to do |format|
      format.json {
        render json: {location: login_url}
      }
      format.html {
        redirect_to login_url, notice: "Logged out!", status: 303
      }
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
