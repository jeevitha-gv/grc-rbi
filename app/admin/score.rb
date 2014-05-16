ActiveAdmin.register Score do

    # remove new record creation option
    actions :all, :except => [:new]

  permit_params :id, :level, :description
  
  #display the required fields in index
  index do                            
    column :level        
    column :description     
    actions    
  end     
  
  #form for edit scores
   form do |f|
    f.inputs "Edit scores" do
      f.input :level
      f.input :description
    end
    f.actions
  end
  
end
