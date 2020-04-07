class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.name}! You are now registered and logged in!"
      redirect_to '/profile'
    # elsif user_params[:password] != user_params[:password_confirmation]
    #   flash[:notice] = "Your password fields do not match. #{@user.errors.full_messages.to_sentence}"
    #   render(:new)
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render(:new)
    end
  end

  def login
  end

  def profile
  end


  private

  def user_params
    params.require(:user).permit(:name, :street_address, :city, :state, :zip_code, :email_address, :password, :password_confirmation)
  end

end
