ActiveAdmin.register User do

  
menu :if => proc{ !current_admin_user.present? }

index do
  selectable_column
  column :company_id
  column :full_name
  column :email
  column :user_name
  actions
end

show do 
  attributes_table :full_name, :email, :user_name
end


form do |f|
  f.inputs "User Details" do
    if f.object.new_record?
      f.input :full_name
      f.input :email
      f.input :user_name
      f.input :password
      f.input :password_confirmation
    else
      f.input :full_name
      f.input :email , :input_html => { :disabled => true } 
      f.input :user_name
    end
  end
  f.actions
end
  
end
