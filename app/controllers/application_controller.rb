class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #publicactivity gem
  include PublicActivity::StoreController
  protect_from_forgery with: :exception
  before_filter :check_subdomain
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale, :if => :current_user
  before_filter :set_time_zone, :if => :current_user
  helper_method :current_company

<<<<<<< HEAD
 
=======
>>>>>>> 60879cce425b14f6a6ba66896c8c6334045add38
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:sign_up) << :full_name
  end

  #To check company admin for settings
  def authenticate_admin_user
    if current_user.role_title == 'company admin'
      redirect_to '/admin/dashboard'
    end
  end
  
  # Return current company for logged_in user
  def current_company
    @company ||= current_user.company if current_user.present?
  end
  
  # will check for sudomain presence and correct subdomain
  def check_subdomain
    if(request.subdomain.present? || current_company.present?)
      current_company.present? ? check_current_company_domain : (redirect_to current_path_without_subdomain)
    end
  end
  
  # Escape the subdomain from the given url
  def escape_subdomain
    if(request.subdomain.present?)
      redirect_to current_path_without_subdomain
    end
  end
  
  # Checks whether current domain matches the logged_in company domain
  def check_current_company_domain
    unless(current_company.domain.eql?(request.subdomain))
      redirect_to current_path_with_subdomain
    end
  end
  
  # Will not allow to access the page if authenticated
  def skip_if_authenticated
    if(current_user)
      redirect_to root_path
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
  
  # Returns URL with subdomain.. Call this function after User logged_in areas
  def current_path_with_subdomain
    "http://" + current_company.domain + "." + request.domain + request.fullpath
  end
  
  # Returns URL without subdomain..
  def current_path_without_subdomain
    "http://" + request.domain + request.fullpath
  end
<<<<<<< HEAD
=======

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
>>>>>>> 60879cce425b14f6a6ba66896c8c6334045add38
end
