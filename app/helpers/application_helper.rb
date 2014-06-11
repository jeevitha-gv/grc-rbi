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



def link_to_add_fields(name, f, association)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder)
  end
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "plus-icon"}
end

def link_to_add_choices(name, f, association)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder)
  end
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "plusround-icon plus-background"}
end

def link_to_remove_fields(name, f)
  f.hidden_field(:_destroy) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_fields(this)", class: "minus-icon"})
end

def link_to_remove_choices(name, f)
  f.hidden_field(:_destroy) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_options(this)", class: "minusround-icon"})
end

end
