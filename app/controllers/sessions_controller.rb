class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])&.authenticate(params[:user][:password])

    if @user
      reset_session
      session[:user_id] = @user.id
      redirect_to user_path(@user.name), notice: "Logged in successfully"
    else
      flash.now[:alert] = "Login failed"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully"
  end
end
