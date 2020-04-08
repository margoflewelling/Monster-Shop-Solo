class User::SessionsController < ApplicationController

  def create
    user = User.find_by(email_address: params[:email_address])
    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.name}! You are now logged in!"
      redirect_based_on_role(user.role)
    else
      flash[:notice] = "Your email or password is incorrect"
      redirect_to '/login'
    end
  end


end
