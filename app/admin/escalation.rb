ActiveAdmin.register Escalation do
breadcrumb do
    [
      link_to('Escalation', '/admin/escalations')
    ]
  end

  menu :if => proc{ !current_admin_user.present? }
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  permit_params :value, :user, :level, :incident_priority_id,:time_line,:mail_count, :to, :cc, :bcc

  
end
