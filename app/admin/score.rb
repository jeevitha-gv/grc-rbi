ActiveAdmin.register Score do

  menu :if => proc{ current_admin_user.present? }

  # remove new record creation option
  actions :all, :except => [:new]
  actions :all, :except => [:destroy]

  #authentication
  controller do
    before_filter :check_company_admin
  end

  permit_params :id, :level, :description

  #display the required fields in index
  index do
    selectable_column
    column :level
    column :description
    actions
  end

  form do |f|
    f.inputs "Edit scores" do
      f.input :level, :input_html => { :disabled => true }
      f.input :description
    end
    f.actions
  end

end
