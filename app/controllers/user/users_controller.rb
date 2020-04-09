class User::UsersController < User::BaseController

  def profile
    @user = User.find(session[:user_id])
  end

  def orders
    @user = User.find(session[:user_id])
    @orders = @user.orders
  end

end
