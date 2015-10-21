class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def sign_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def sign_out!(user)
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
  end

  def already_signed_in
    redirect_to cats_url if current_user
  end

  def not_signed_in
    unless current_user
      redirect_to root_url
      flash[:message] ||= []
      flash[:message] << "Please sign up or sign in."
    end
  end

  def set_flash(message)
    flash[:message] ||= []
    flash[:message] << message
  end


end
