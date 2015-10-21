class SessionsController < ApplicationController

  before_action :already_signed_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name],
                                     params[:user][:password])
    if @user
      sign_in!(@user)
      redirect_to cats_url
    else
      flash[:message] ||= []
      flash[:message] << "Unknown user name or password"
      redirect_to new_session_url
    end
  end

  def destroy
    sign_out!(current_user)
    redirect_to new_session_url
  end
end
