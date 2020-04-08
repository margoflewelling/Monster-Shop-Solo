class User::SessionsController < ApplicationController

  def create
    user = User.find_by(email_address: params[:email_address])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/user/profile'
    else
      flash[:notice] = "Your email or password is incorrect"
      redirect_to '/login'
    end
  end
end