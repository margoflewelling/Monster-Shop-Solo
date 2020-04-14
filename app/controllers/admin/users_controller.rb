class Admin::UsersController < Admin::BaseController
  def user_names
  end

  def show
    @user = User.find(params[:user_id])
  end
end
