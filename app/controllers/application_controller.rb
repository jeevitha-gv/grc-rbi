class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale, :if => :current_user
  before_filter :set_time_zone, :if => :current_user
  helper_method :current_company

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:sign_up) << :full_name
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
    begin
      I18n.locale  = ::Language.find(current_user.language_id).code || I18n.default_locale
      MESSAGES.replace ::ALLMESSAGES["#{I18n.locale}"]
    rescue ActiveRecord::RecordNotFound
      redirect_to welcome_path
      return
    end
  end

  def set_time_zone
    case current_user.timezone || current_company.timezone
    when current_user.timezone
      Time.zone = current_user.timezone
    when current_company.timezone
      Time.zone = current_company.timezone
    else
      Time.zone = "London"
    end
  end
end
