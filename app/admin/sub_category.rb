ActiveAdmin.register SubCategory do
	permit_params :category_id,:name

  config.filters = false
   index do
    # selectable_column
    column :name 
     actions
  end

end
