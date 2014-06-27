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
    if ["clients","locations", "departments", "teams","roles","users","settings"].include?(action_path)
      'overview'
    elsif ["operational_areas","artifacts", "reminders"].include?(action_path)
      'audit'
    elsif ["controls","procedures", "processes"].include?(action_path)
     'risk' 
    else
      ''
    end
  end
end