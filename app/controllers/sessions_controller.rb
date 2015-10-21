class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name],
                                     params[:user][:password])
    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to casts_url
    end
  end

  def destroy
  end
end