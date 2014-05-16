ActiveAdmin.register Score do

  #authentication
  controller do
    before_filter :authenticate_admin_user!
  end
  
    # remove new record creation option
    actions :all, :except => [:new]

  permit_params :id, :level, :description
  
  #display the required fields in index
  index do                            
    column :level        
    column :description     
    actions    
  end     
  
   form do |f|
    f.inputs "Edit scores" do
      f.input :level, :hidden_input => true
      f.input :description
   
    end
    f.actions
  end
  
end
