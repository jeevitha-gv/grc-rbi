class ApplicationController < ActionController::Base
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
  helper_method :current_audit
  before_filter :check_subdomain, :if => :admin_function
  before_filter :check_password_authenticated, :if => :current_user
  
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

  def current_audit
    Audit.find(cookies[:audit_id].to_i) if cookies[:audit_id].present? rescue nil
  end
  
  def admin_function
    if request.url.include?("/admin")
      return false 
    else
      return true
    end
  end

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

# Escape the subdomain if there is no company
  def escape_subdomain_with_company
    if(request.subdomain.present? && !Company.where(domain: request.subdomain).present?)
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

  # check for password to access the page
  def check_password_authenticated
    redirect_to password_user_path unless current_user.encrypted_password.present?
  end

  # check for company disable status
  def check_company_disabled
     if current_company.is_disabled == true
      sign_out current_user
      redirect_to root_path
    end
  end

  #To check company admin
    def check_company_admin
      if(!current_user || current_company.id != current_user.company_id)
        flash[:alert] = "Access restricted"
        redirect_to '/users/sign_in' 
      end
    end

  def check_role
    role = current_user.role_title
    if role == 'company_admin'
      return true
    else
      flash[:alert] = "Access restricted"
      redirect_to '/users/sign_in'
    end
  end

  def set_cookie_audit
    unless cookies[:audit_id].present?
      cookies[:audit_id] = { :value => current_user.accessible_audits.last.id, :expires => 24.hour.from_now } if current_user.accessible_audits.present?
    end
  end
  
  def check_for_current_audit
    unless current_audit.present?
      flash[:alert] = "Access restricted"
      redirect_to root_path
    end
  end

  def authorize_auditor
	  	unless current_audit.auditor == current_user.id
        flash[:alert] = "Access restricted"
	  		redirect_to audits_path
	  	end
  end

	def authorize_auditees
	  	unless current_audit.auditees.map(&:id).include?(current_user.id)
        flash[:alert] = "Access restricted"
	  		redirect_to audits_path
	  	end
	end
  
  def authorize_auditor_skip_company_admin
	  	if(current_audit.auditor != current_user.id && current_user.role_title != "company_admin")
        flash[:alert] = "Access restricted"
	  		redirect_to audits_path
	  	end
  end

	def authorize_auditees_skip_company_admin
      if(!current_audit.auditees.map(&:id).include?(current_user.id) && current_user.role_title != "company_admin")
        flash[:alert] = "Access restricted"
	  		redirect_to audits_path
	  	end
  end
    
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def authenticate_subscription
    if !Subscription.where("name = ?",params[:subscription]).present? && controller_name.eql?("companies") && action_name.eql?("new")
        redirect_to new_plan_path
    end
  end

  def calculate_plan_expiration(period,log,created_at)
  #period = period == 1 ? "Days" : period == 2 ? "Months" : "Year"
  start = created_at.to_date
  case period    
  when 1
    start + log.days
  when 2
    start + log.months
  when 3
    start + log.year
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
