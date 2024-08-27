class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login, except: [:new, :create]

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this application'
    end
  end
end
