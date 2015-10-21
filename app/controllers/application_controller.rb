class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    return if session[:session_token].nil?
    Session.where("session_token = ?", session[:session_token]).first.user
  end

  def sign_in!(user)
    session[:session_token] = user.add_session.session_token
  end

  def signed_in?
    !!current_user
  end

  def sign_out!(user)
    return if session[:session_token].nil?
    Session.find_by_session_token(session[:session_token]).destroy!
    session[:session_token] = nil
  end

  def already_signed_in
    redirect_to cats_url if signed_in?
  end

  def not_signed_in
    unless signed_in?
      redirect_to root_url
      set_flash("Please sign up or sign in.")
    end
  end

  def set_flash(message)
    flash[:message] ||= []
    flash[:message] << message
  end


end
