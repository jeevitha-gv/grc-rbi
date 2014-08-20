ActiveAdmin.register SubCategory do
	permit_params :incident_category_id,:name

  config.filters = false
   index do
    # selectable_column
    column :name 
     actions
  end

    form do |f|
    f.inputs "New SubCategory" do
      f.input :incident_category_id, :label => 'Category', :as => :select, :collection => IncidentCategory.all, :prompt => "-Select category-"
      f.input :name
    end
    f.actions
  end
end
