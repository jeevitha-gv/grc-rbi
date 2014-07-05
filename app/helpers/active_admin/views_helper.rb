module ActiveAdmin::ViewsHelper #camelized file name
  def add_admin_active_class(params)
    case params[:controller]
    when 'admin/settings', 'admin/departments', 'admin/locations', 'admin/teams', 'admin/users', 'admin/clients', 'admin/roles', 'admin/dashboard', 'admin/compliances', 'admin/companies', 'admin/modulars', 'admin/priorities', 'admin/question_types', 'admin/languages', 'admin/sections', 'admin/topics', 'admin/scores', 'admin/plans'
      'Settings'
    when 'admin/operational_areas','admin/artifacts','admin/reminders'
      'Audit'
    when 'admin/controls','admin/procedures','admin/processes','admin/risk_review_levels','admin/projects'
      'Risk'
    else
      return ''
    end
  end

  def add_sub_menu(action_path)
    if ["clients","locations", "departments", "teams","roles","users","settings", "plans"].include?(action_path)
      'overview'
    elsif ["operational_areas","artifacts", "reminders"].include?(action_path)
      'audit'
    elsif ["controls","procedures", "processes","risk_review_levels","projects"].include?(action_path)
     'risk'
    else
      ''
    end
  end

  def super_admin_sub_menu(action)
    if ["dashboard","companies","languages"].include?(action)
      'overview'
    elsif ["compliances","modulars", "priorities","question_types","sections","topics","scores","compliance_libraries"].include?(action)
      'audit'
    elsif ["planning_strategies","reviews", "next_steps","risk_approval_statuses","implementation_statuses","close_reasons"].include?(action)
     'risk'
    elsif action == ""
      'overview'
    else
      ''
    end
  end
end