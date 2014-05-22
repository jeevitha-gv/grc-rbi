class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #publicactivity gem
  include PublicActivity::StoreController
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale, :if => :current_user
  before_filter :set_time_zone, :if => :current_user
  helper_method :current_company
  before_filter :check_subdomain

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
      redirect_to root_subdomain_path
    end
  end

  def set_locale
      I18n.locale  = ::Language.where(current_user.language_id).first.code || I18n.default_locale
      MESSAGES.replace ::ALLMESSAGES["#{I18n.locale}"]
  end
  
  # Returns URL with subdomain.. Call this function after User logged_in areas
  def current_path_with_subdomain
    request.protocol + current_company.domain + "." + request.domain + (request.port.nil? ? '' : ":#{request.port}") + request.fullpath
  end

 # Returns URL with subdomain.. Call this function after User logged_in areas
  def root_subdomain_path
    request.protocol + current_company.domain + "." + request.domain + (request.port.nil? ? '' : ":#{request.port}")
  end
  
  # Returns URL without subdomain..
  def current_path_without_subdomain
    "http://" + request.domain + (request.port.nil? ? '' : ":#{request.port}") + request.fullpath
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
  
   #redirect to home page if you don't have access
   rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end
  
  #check the ability of current_user
   def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
