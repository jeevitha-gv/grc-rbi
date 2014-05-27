ActiveAdmin.register User do


menu :if => proc{ !current_admin_user.present? }

  #authentication
  controller do
    before_filter :check_company_admin
  end

# removing delete option
actions :all, :except => [:destroy]


index do
  selectable_column
  column :full_name
  column :email
  column :user_name
  column :is_disabled
  column :team
  actions
end

show do
  attributes_table :full_name, :email, :user_name
end

  permit_params :full_name, :email, :user_name, :password , :password_confirmation, :is_disabled, profile_attributes: [:personal_email, :address2, :address1]


form do |f|
  f.object.profile ? f.object.profile : f.object.build_profile
    f.inputs "User Details" do
      f.input :full_name
      if f.object.new_record?
        f.input :email
      else 
        f.input :email, :input_html => { :disabled => true }
      end
      f.input :user_name
      f.input :is_disabled
      f.input :teams, :class => ""
    end
    f.inputs "Other Information", for: [:profile, f.object.profile] do |s|
      s.input :personal_email
      s.input :address1
      s.input :address2
    end
  f.actions
end



controller do
  def create
    @user = User.new(user_params)
    @user.company_id = current_user.company_id
    if @user.save
      redirect_to admin_users_path
    else
      redirect_to new_admin_user_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:full_name, :email, :user_name, :is_disabled, :company_id, profile_attributes: [:personal_email, :address2, :address1])
    end

    def scoped_collection
      current_user.company.users
    end
end


end




