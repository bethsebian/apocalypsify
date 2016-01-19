class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      set_user
      redirect_to dashboard_path
    else
      flash.now[:error] = {message: @user.errors.full_messages.join(", "), color: "red"}
      redirect_to new_user_path
    end
  end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :password,
      :password_confirmation
    )
  end

end
