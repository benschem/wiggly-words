class UsersController < ApplicationController
  before_action :authenticate_user, only: [ :index, :show, :update, :destroy ]
  before_action :authorise_user, only: [ :update, :destroy ]

  def index
    @users = User.all
  end

  # get /users/:username(.:format)
  def show
  end

  def update
    @user = User.update(user_params)
    if @user.save
      redirect_to users_path(@user.name), notice: "User updated successfully."
    else
      flash.now[:alert] = "User not updated"
      render :new, status: :unprocessable_entity
    end
  end

  def new
    if user_signed_in?
      flash.now[:alert] = "You are already signed in as #{current_user.name}"
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to user_path(@user.name), notice: "User created successfully."
    else
      flash.now[:alert] = "User not created"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    raise
    if @user.destroy
      redirect_to users_path, notice: "User deleted successfully"
    else
      redirect_to users_path, alert: "Failed to delete user", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
