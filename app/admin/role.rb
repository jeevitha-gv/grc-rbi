ActiveAdmin.register Role  do
 menu :if => proc{ !current_admin_user.present? }
 #authentication
  controller do
   before_filter :check_role, :check_company_admin
   action :all, except: [:new]
    def scoped_collection                                                                                                                                                                                                                                                
     @privileges=Role.where('company_id= ?', current_user.company_id)
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
        p current_user.role_id
        p role = Role.where('id =?', current_user.role_id).first.title if current_user.role_id.present?
         if role == 'company admin'
          return true
         else
           redirect_to '/users/sign_in'
         end
       end
       
<<<<<<< HEAD
      #To check company admin
      def check_company_admin
        p current_company.roles
        if current_company.roles.present?
          p current_company.roles
          company_admin_id = current_company.roles.where('title= ?' ,'company admin').first.id if (current_company.id == current_user.company_id && current_company.roles.present?)
          current_user.role_id 
          unless company_admin_id.nil?
            result = current_user.role_id == company_admin_id ?  true : false
              redirect_to '/users/sign_in'  if result == false
            end
        end
      end
       
=======
>>>>>>> b3e63592a9fd97e22ad40ba521eeefce713597cd
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




