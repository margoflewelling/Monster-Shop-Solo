class User::UsersController < User::BaseController

  def profile
    @user = User.find(session[:user_id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:message] = "Your information is updated"
      redirect_to :user_profile
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :street_address, :city, :state, :zip_code, :email_address, :password, :confirm_password)
  end
end
