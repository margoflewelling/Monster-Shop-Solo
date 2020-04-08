class User::SessionsController < ApplicationController

  def create
    user = User.find_by(email_address: params[:email_address])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.name}! You are now logged in!"
      if user.role == "merchant"
        redirect_to "/merchant"
      elsif user.role == "admin"
        redirect_to "/admin"
      else
        redirect_to '/user/profile'
      end

    else
      flash[:notice] = "Your email or password is incorrect"
      redirect_to '/login'
    end
  end
end
