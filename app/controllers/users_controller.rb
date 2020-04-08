class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.name}! You are now registered and logged in!"
      session[:user_id] = @user.id
      redirect_to '/user/profile'
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render(:new)
    end
  end

  def logout

  end


  private

  def user_params
    params.require(:user).permit(:name, :street_address, :city, :state, :zip_code, :email_address, :password, :password_confirmation)
  end

end
