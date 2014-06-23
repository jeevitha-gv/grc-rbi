class ApplicationController < BaseController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #publicactivity gem
  include PublicActivity::StoreController
  include ActiveSupport::Rescuable
  protect_from_forgery with: :exception
  before_filter :set_cache_buster
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale, :if => :current_user
  before_filter :set_time_zone, :if => :current_user
  before_filter :authenticate_user!, :if => :admin_function
  helper_method :current_company
  before_filter :set_cookie_audit, :if => :current_user
  helper_method :current_audits
  before_filter :check_subdomain, :if => :admin_function
  before_filter :check_password_authenticated, :if => :current_user
  
  # Rescue for 400 and 500 errors 
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected
  # Fetch Audit from Cookie
  def current_audits
    Audit.find(cookies[:audit_id].to_i) if cookies[:audit_id].present? rescue nil
  end
  
  # Check functions is for company admin and Super admin
  def admin_function
    if request.url.include?("/admin")
      return false 
    else
      return true
    end
  end
  
  # Devise Strong Parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:sign_up) << :full_name
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, :domain) }
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

  # Will not allow to access the page if authenticated
  def skip_if_authenticated
    if(current_user)
      redirect_to root_subdomain_path
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

  # check for password to access the page
  def check_password_authenticated
    redirect_to password_user_path unless current_user.encrypted_password.present?
  end

  # Clear the header and Cache
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
    
  private

  # Render error from rescue
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: false, :locals => {status: status, exception: exception}  }
      format.all { render nothing: true, status: status }
    end
  end
end
