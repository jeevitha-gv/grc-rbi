ActiveAdmin.register Compliance do

  menu :if => proc{ !current_admin_user.present? }
   controller do
    before_filter :check_company_admin
  end
  
   permit_params :name

   index do
    selectable_column
   	column :name
   	actions
   end

   show do 
 	 attributes_table :name
   end

   form do |f|
    f.inputs "Add Compliance" do
      f.input :name
    end
    f.actions
   end
end
