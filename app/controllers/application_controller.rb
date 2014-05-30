class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #publicactivity gem
  include PublicActivity::StoreController
  include ActiveSupport::Rescuable
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale, :if => :current_user
  before_filter :set_time_zone, :if => :current_user
  helper_method :current_company
  before_filter :check_subdomain
  before_filter :check_password_authenticated, :if => :current_user
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: lambda { |exception| render_error 500, exception }
      rescue_from ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:sign_up) << :full_name
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  end

  #To check company admin for settings
  def authenticate_admin_user
    if current_user.role_title == 'company_admin'
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
      I18n.locale  = current_user.language_id.present? ? ::Language.current_user_language(current_user.language_id).first.code : I18n.default_locale
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
      Time.zone = "Mumbai"
    end
  end

  # Routing to sign in path after signout
  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_name)
  end

  #redirect to home page if you don't have access
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  #check the ability of current_user
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def check_password_authenticated
    redirect_to password_user_path unless current_user.encrypted_password.present?
  end

  #To check company admin
    def check_company_admin
      result = current_company.id == current_user.company_id ? true : false if current_user.company_id
      redirect_to '/users/sign_in'  if result == false
        #~ company_admin_id = current_company.roles.where('title= ?' ,'company admin').first.id if (current_company.id == current_user.company_id && current_company.roles.present?)
        #~ current_user.role_id
        #~ unless company_admin_id.nil?
          #~ result = current_user.role_id == company_admin_id ?  true : false
            #~ redirect_to '/users/sign_in'  if result == false
          #~ end
      end

  def check_role
    role = Role.where('id =?', current_user.role_id).first.title if current_user.role_id.present?
    if role == 'company_admin'
      return true
    else
      redirect_to '/users/sign_in'
    end
  end

  private

  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: false, :locals => {status: status, exception: exception}  }
      format.all { render nothing: true, status: status }
    end
  end
end
