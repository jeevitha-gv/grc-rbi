ActiveAdmin.register User do
  menu :if => proc{ !current_admin_user.present? }

  # removing delete option
  actions :all, :except => [:destroy]

  permit_params :full_name, :email, :user_name, :password , :password_confirmation, :is_disabled, profile_attributes: [:personal_email, :address2, :address1]

  controller do

# removing delete option
actions :all, :except => [:destroy]
    before_filter :check_company_admin
    def create
      @user = User.new(user_params)
      @user.company_id = current_user.company_id
      if @user.save
        redirect_to admin_users_path
      else
        # redirect_to new_admin_user_path
        render 'new'
      end
    end

    private
      def user_params
        params.require(:user).permit(:full_name, :email, :user_name, :is_disabled, :company_id, profile_attributes: [:personal_email, :address2, :address1])
      end

      def scoped_collection
        current_company.users
      end
  end

  index do
    selectable_column
    column :full_name
    column :email
    column :user_name
    column :team
    column :is_disabled
    actions
  end

  show do
    attributes_table :full_name, :email, :user_name
  end


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
      f.input :teams, :class => ""
      f.input :role_id, :label => 'Role', :as => :select, :collection => current_company.roles, :prompt => "-Select Role-"
      f.input :is_disabled
    end
    f.inputs "Other Information", for: [:profile, f.object.profile] do |s|
      s.input :personal_email
      s.input :address1
      s.input :address2
    end
    f.actions
   end
end
