ActiveAdmin.register QuestionType do

  menu :if => proc{ !current_admin_user.present? }

   permit_params :name

   index do 
   	column :name
   	actions
   end

   show do 
 	 attributes_table :name
   end

   form do |f|
    f.inputs "Add Question type" do
      f.input :name
    end
    f.actions
   end
  
end
