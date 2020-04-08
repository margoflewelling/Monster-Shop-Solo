class User::UsersController < ApplicationController

  def profile
    @user = User.find(session[:user_id])
  end

end