module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :user_signed_in?
  end

  def current_user
    # If the user has been checked this request, return @current_user
    # Otherwise, if session[:user_id] is nil, set @current_user to nil
    # Otherwise set @current_id to the correct user instance
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def authenticate_user
    # Ensure the user is authorised based on the username in params
    if current_user.nil? || current_user.name != params[:username]
      redirect_to root_path, alert: "You need to be logged in."
    end
  end

  def authorise_user
    if current_user.name != params[:username]
      redirect_to root_path, alert: "Unauthorised access."
    end
  end

  def user_signed_in?
    current_user.present?
  end
end
