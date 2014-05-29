module ActiveAdmin::ViewsHelper #camelized file name
  def add_admin_active_class(params)
    case params[:controller]
    when 'admin/settings', 'admin/departments', 'admin/locations', 'admin/teams', 'admin/users', 'admin/clients', 'admin/roles', 'admin/dashboard', 'admin/compliances', 'admin/companies', 'admin/modulars', 'admin/priorities', 'admin/question_types', 'admin/languages', 'admin/sections', 'admin/topics', 'admin/scores'
      'Settings'
    when 'admin/audits'
      'Audit'
    when 'admin/risks'
      'Risk'
    else
      return ''
    end
  end
end