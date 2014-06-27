module ActiveAdmin::ViewsHelper #camelized file name
  def add_admin_active_class(params)
    case params[:controller]
    when 'admin/settings', 'admin/departments', 'admin/locations', 'admin/teams', 'admin/users', 'admin/clients', 'admin/roles', 'admin/dashboard', 'admin/compliances', 'admin/companies', 'admin/modulars', 'admin/priorities', 'admin/question_types', 'admin/languages', 'admin/sections', 'admin/topics', 'admin/scores'
      'Settings'
    when 'admin/operational_areas','admin/artifacts','admin/reminders'
      'Audit'
    when 'admin/controls','admin/procedures','admin/processes'
      'Risk'
    else
      return ''
    end
  end
  
  def add_sub_menu(action_path)
    action = 'overview' if ["clients","locations", "departments", "teams","roles","users","settings"].include?(action_path)
    action = 'audit' if ["operational_areas","artifacts", "reminders"].include?(action_path)
    action = 'risk' if ["controls","procedures", "processes"].include?(action_path)
    return action
  end
end