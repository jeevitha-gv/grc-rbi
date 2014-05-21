class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale
  helper_method :current_company

 
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:sign_up) << :full_name
    devise_parameter_sanitizer.for(:sign_up) << :time_zone
  end

  #To check company admin for settings
  def authenticate_admin_user
    if current_user.roles.first.title == 'company admin'
      redirect_to '/admin/dashboard'
    end
  end

  def current_company
    begin
      Company.find_by_id(current_user.company_id)
    rescue ActiveRecord::RecordNotFound
      redirect_to welcome_path
      return
    end
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
