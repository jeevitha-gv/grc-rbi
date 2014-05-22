class UsersController < ApplicationController

  before_filter :authenticate_user!


  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to audits_path
    else
      render "edit"
    end
  end

  def password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update(password_params)
      # Sign in the user by passing validation in case his password changed
      sign_in(@user, :bypass => true)
      redirect_to root_subdomain_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name,:full_name)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end