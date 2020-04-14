class Admin::UsersController < Admin::BaseController
  def user_names
    @users = User.all
  end

  def show
    @user = User.find(params[:user_id])
  end
end
