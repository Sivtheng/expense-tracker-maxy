class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      Rails.logger.debug("User logged in: #{user.id}")
      redirect_to expenses_path # Redirect without notice
    else
      flash.now[:alert] = "Invalid name or password"
      render :new
    end
  end

  def destroy
    Rails.logger.debug("Logging out user: #{session[:user_id]}")
    session[:user_id] = nil
    reset_session
    redirect_to login_path # Redirect without notice
  end
end
