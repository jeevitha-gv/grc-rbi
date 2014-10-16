module ActiveAdmin::ViewsHelper #camelized file name
  def add_admin_active_class(params)
    case params[:controller]
    when 'admin/settings', 'admin/departments', 'admin/locations', 'admin/teams', 'admin/users', 'admin/clients', 'admin/roles', 'admin/dashboard', 'admin/compliances', 'admin/companies', 'admin/modulars', 'admin/priorities', 'admin/question_types', 'admin/languages', 'admin/sections', 'admin/topics', 'admin/scores', 'admin/plans','admin/transactions','admin/privileges'
      'Settings'
    when 'admin/operational_areas','admin/artifacts','admin/reminders'
      'Audit'
    when 'admin/controls','admin/procedures','admin/processes','admin/risk_review_levels','admin/projects'
      'Risk'
    when 'admin/slas','admin/escalations','admin/incident_categories'
      'Incident'
    else
      return ''
    end
  end
  
  def add_super_admin_active_class(params)
    case params[:controller]
    when 'admin/dashboard','admin/companies','admin/sections','admin/modulars','admin/languages','admin/subscriptions'
      'Settings'
    when 'admin/compliances','admin/priorities','admin/question_types','admin/topics','admin/scores','admin/compliance_libraries'
      'Audit'
    when 'admin/planning_strategies','admin/reviews','admin/next_steps','admin/risk_approval_statuses','admin/implementation_statuses','admin/close_reasons'
      'Risk'
    else
      return ''
    end
  end

  def add_sub_menu(action_path)
    if ["clients","locations", "departments", "teams","roles","privileges","users","settings", "plans","transactions"].include?(action_path)
      'overview'
    elsif ["operational_areas","artifacts", "reminders"].include?(action_path)
      'audit'
    elsif ["controls","procedures", "processes","risk_review_levels","projects"].include?(action_path)
     'risk'
    elsif ["slas","escalations", "incident_categories"].include?(action_path)
     'incident'
    else
      ''
    end
  end

  def super_admin_sub_menu(action)
    if ["dashboard","companies","sections","modulars","languages","subscriptions"].include?(action)
      'overview'
    elsif ["compliances", "priorities","question_types","topics","scores","compliance_libraries"].include?(action)
      'audit'
    elsif ["planning_strategies","reviews", "next_steps","risk_approval_statuses","implementation_statuses","close_reasons"].include?(action)
     'risk'
    elsif action == ""
      'overview'
    else
      ''
    end
  end
  
  def company_modules_check(module_name)
    module_id = Section.find_by_name(module_name).id
    current_company.plan.subscription_section_ids.include?("#{module_id}")
  end

  def company_plan_check
    current_company.plan.expires.to_date < Date.today
  end

  def check_for_free_plan
    current_company.subscriptions.last.amount  == 0.0
  end
  
end