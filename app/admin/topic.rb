ActiveAdmin.register Topic do

  menu :if => proc{ !current_admin_user.present? }

  permit_params :id , :name



  index do 
    selectable_column
   	column :name
   	actions
  end


   show do 
 	 attributes_table :name
   end

  form do |f|
    f.inputs "Topics for Non Compliance" do
      f.input :name
    end
    f.actions
  end  
end
