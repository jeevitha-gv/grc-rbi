ActiveAdmin.register Role  do
 menu :if => proc{ !current_admin_user.present? }

  permit_params :title, :company_id
 
 #authentication
  controller do
   before_filter :check_role, :check_company_admin
   action :all, except: [:new]


    def scoped_collection
      current_company.roles
    end

    def create
      role = Role.where("title= ? AND company_id= ?", params[:role][:title], current_user.company_id).first
      unless role.present?
        @role = Role.new(role_params)
        @role.company_id = current_user.company_id
        if @role.save
          @role.create_activity :create, owner: current_user 
          flash[:now]=  MESSAGES["Role"]["create"]["success"]
          redirect_to admin_roles_path
        else
          render 'new'
        end
      else
        redirect_to new_admin_role_path
      end
		end

    private
      def role_params
        params.require(:role).permit(:title, :company_id)
      end
  end

  #display the required fields in index
  index  do
    column :title
    actions  do |f|
      link_to "Add privilege" , "/admin/privileges/new?role_id=#{f.id}"#, :onclick => "test();"
    end
  end


  form do |f|
    f.inputs "Roles" do
      f.input :title
    end
    f.actions
  end
end




