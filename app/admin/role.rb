ActiveAdmin.register Role  do
 menu :if => proc{ !current_admin_user.present? }
 #authentication
  controller do
   before_filter :check_role
   action :all, except: [:new]
    def scoped_collection                                                                                                                                                                                                                                                
     @previleges=Role.where('company_id= ?', current_user.company_id)
		end
   
    def create
      @role = Role.new(role_params)
      @role.company_id = current_user.company_id
      if @role.save
        redirect_to admin_roles_path
      else
        redirect_to new_admin_role_path
			end
		end
    
    def update
      @role = Role.find_by_id(params[:id])
      @role.update_attributes(:title => params[:role][:title])
      if @role
        redirect_to admin_roles_path
      else
        redirect_to new_admin_role_path
     end
   end

    private
      def role_params
        params.require(:role).permit(:title, :company_id)
       end
       def check_role
        role = Role.where('id =?', current_user.role_id).first.title if current_user.role_id.present?
         if role == 'company admin'
          return true
         else
           redirect_to '/users/sign_in'
         end
          
       end
  end
 
  
  #display the required fields in index
  
  index  do
    
    column :title
    actions  do |f|
      link_to "Add privilege" , "/admin/previleges/new?role_id=#{f.id}"#, :onclick => "test();"
    end
  end  
  
  
  form do |f|
    f.inputs "Roles" do
      f.input :title
    end
    f.actions
  end
end




