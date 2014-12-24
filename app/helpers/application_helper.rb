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
    when 'audits', 'audit_compliances', 'checklist_recommendations', 'nc_questions'
      'Audit'
    when 'users'
      'User'
    when 'risks'
      'Risk'
    when 'incidents'
      'Incident'
    when 'assets', 'information_assets', 'computers', 'mobile_assets', 'softwares', 'services', 'other_assets', 'documents', 'source_codes', 'assessments', 'asset_actions', 'asset_reviews', 'asset_dashboard'
      'Asset'

    when 'controls'
      'Control'

    when 'bc_analyses', 'bcm_dashboard', 'bc_acceptances', 'bc_implementations', 'bc_maintenances', 'bc_plans'
      'BCPM'

    else
      return ''
    end
  end

  def overview_header
    return true if (request.fullpath.include?("user/edit") == true ||  request.fullpath == "/" || request.fullpath.include?("activities") == true || request.fullpath.include?("user/password") == true || request.fullpath.include?("user/update_password") == true || request.fullpath.include?("charges/new") == true) 
  end

# def link_to_add_fields(name, f, association)
#   new_object = f.object.class.reflect_on_association(association).klass.new
#   fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
#     render(association.to_s.singularize + "_fields", :f => builder)
#   end
#   link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "plus-icon"}
# end

def link_to_add_nc_question_fields(name, f, association, audit)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder, audit: audit)
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

def link_to_add_auditee(name, association)
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_auditees(this, \"#{association}\")", class: "plusround-icon plus-background"}
end

def link_to_remove_fields(name, f)
  f.hidden_field(:_destroy) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_fields(this)", class: "minus-icon"})
end

def link_to_remove_choices(name, f)
  f.hidden_field(:_destroy) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_options(this)", class: "minusround-icon"})
end

def link_to_remove_auditee(name, f)
  f.hidden_field(:_destroy, {class: "auditee-remove"}) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_options_audit(this)", class: "minusround-icon"})
end

def check_stage(stage, compliance_url, non_compliance_url)
 return true if ((request.fullpath.include?('stage=do') || request.fullpath.include?(non_compliance_url) || request.fullpath.include?(compliance_url)) == true)
end

  def company_modules_check(module_name)
    module_id = Section.find_by_name(module_name).id
    current_company.plan.subscription_section_ids.include?("#{module_id}")
  end

  def company_plan_check
    current_company.plan.expires.to_date < Date.today if current_company.plan.expires.present?
  end

def link_to_add_policy_location(name, association)
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_policy_location(this, \"#{association}\")", class: "plusround-icon plus-background"}
end

def link_to_remove_policy_location(name, f)
  f.hidden_field(:_destroy, {class: "auditee-remove"}) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_policy_location(this)", class: "minusround-icon"})
end

def link_to_add_policy_department(name, association)
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_policy_department(this, \"#{association}\")", class: "plusround-icon plus-background"}
end

def link_to_remove_policy_department(name, f)
  f.hidden_field(:_destroy, {class: "auditee-remove"}) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_policy_department(this)", class: "minusround-icon"})
end

def link_to_add_policy_reviewer(name, association)
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_policy_reviewer(this, \"#{association}\")", class: "plusround-icon plus-background"}
end


def link_to_remove_policy_reviewer(name, f)
  f.hidden_field(:_destroy, {class: "auditee-remove"}) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_policy_reviewer(this)", class: "minusround-icon"})
end


def link_to_add_policy_approver(name, association)
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_policy_approver(this, \"#{association}\")", class: "plusround-icon plus-background"}
end


def link_to_remove_policy_approver(name, f)
  f.hidden_field(:_destroy, {class: "auditee-remove"}) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_policy_approver(this)", class: "minusround-icon"})
end

def link_to_add_lifecycle_fields(name, f, association, lifecycle)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder, lifecycle: lifecycle)
  end
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "plusround-icon plus-backgroundn"}
end

  def calc_score(asset)
    return asset.asset_confi.id + asset.asset_avail.id + asset.asset_integ.id
  end

def link_to_add_distribution_list(name, association)
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_distribution_list(this, \"#{association}\")", class: "plusround-icon plus-background"}
end


def link_to_remove_distribution_list(name, f)
  f.hidden_field(:_destroy, {class: "auditee-remove"}) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_distribution_list(this)", class: "minusround-icon"})
end

def link_to_add_email_list(name, association)
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_email_list(this, \"#{association}\")", class: "plusround-icon plus-background"}
end


def link_to_remove_email_list(name, f)
  f.hidden_field(:_destroy) + link_to("#{name}", 'javascript:void(0)', {onclick: "remove_email_list(this)", class: "minusround-icon"})
end

def link_to_add_email_list(name, f, association)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder)
  end
  link_to "#{name}" ,'javascript:void(0)',  {onclick: "add_email_list(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "plusround-icon plus-background"}
end

end
