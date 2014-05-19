ActiveAdmin.register User do

  
menu :if => proc{ !current_admin_user.present? }

index do
  column :full_name
  column :email
  column :user_name
end

show do 
  attributes_table :full_name, :email, :user_name
end

form do |f|
  f.inputs "User Details" do
    f.input :full_name
    f.input :email
    f.input :user_name
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end


controller do
  def permitted_params
    params.permit!
  end
end
  
end
