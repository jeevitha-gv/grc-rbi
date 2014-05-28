module ApplicationHelper
# creating the URL with subdomain
  def with_subdomain(subdomain)
    subdomain = (subdomain || "")
    subdomain += "." unless subdomain.empty?
    [subdomain, request.domain, request.port_string].join
  end

  def url_for(options = nil)
    if options.kind_of?(Hash) && options.has_key?(:subdomain)
      options[:host] = with_subdomain(options.delete(:subdomain))
    end
    super
  end

  def add_active_class(params)
    case params[:controller]
    when 'audits'
      'Audit'
    when 'users'
      'User'
    when 'risks'
      'Risk'
    else
      return ''
    end
  end
end
