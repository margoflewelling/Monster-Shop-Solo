class User::UsersController < User::BaseController

  def profile
    @user = User.find(session[:user_id])
  end

end
