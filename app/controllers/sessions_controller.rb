class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user.admin?
      set_user
      redirect_to admin_dashboard_path
    elsif @user && @user.authenticate(params[:session][:password])
      set_user
      flash[:success] = {color: 'green', message: "Logged in as #{@user.first_name}"}
      redirect_to dashboard_path
    else
      flash[:error] = {color: 'orange', message: "Username or Password incorrect."}
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = {color: "white", message: "Goodbye"}
    redirect_to '/'
  end

end
