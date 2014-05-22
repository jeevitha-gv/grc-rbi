class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_password , only: [:edit, :update]


  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path
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
    params.require(:user).permit(:user_name,:full_name, profile_attributes: [:personal_email, :phone_no, :address1, :address2, :city, :state, :country])
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
