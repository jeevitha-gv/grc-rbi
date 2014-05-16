class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

before_filter :configure_permitted_parameters, if: :devise_controller?


protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:sign_up) << :full_name
  end

    # Redirection to password reset page 
  	# def after_sign_in_path_for(resource)
  	# 	edit_user_path
  	# end

        def after_confirmation_path_for(resource_name, resource)
      if signed_in?
        signed_in_edit_user_path(resource)
      else
        new_session_path(resource_name)
      end
    end
end
