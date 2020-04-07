class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && params[:password] == params[:confirm_password]
      User.create(user_params)
      flash[:notice] = "Welcome #{@user.name}! You are now registered and logged in!"
      redirect_to '/profile'
    elsif params[:password] != params[:confirm_password]
      flash[:notice] = "Your password fields do not match. #{@user.errors.full_messages.to_sentence}"
      render(:new)
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render(:new)
    end
  end

  def profile
  end


  private

  def user_params
    params.require(:user).permit(:name, :street_address, :city, :state, :zip_code, :email_address, :password)
  end

end
