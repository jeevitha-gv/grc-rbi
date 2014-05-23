ActiveAdmin.register Previlege do
	#To change title bar link
  breadcrumb do
    [
      link_to('Roles', '/admin/roles')
    ]
  end
  
  menu :if => proc{ !current_admin_user.present? }
	#To hide form menu
	menu false
	controller do
      before_filter :authenticate_user!
			skip_before_filter :verify_authenticity_token
			before_filter :role_company, only: [:new]
			
			#To crete new previlege
		 def create
				params[:previlege][:modular_id].each do |previlege_modular_id|
					 previlege =  Previlege.where('role_id =? AND modular_id =?', params[:previlege][:role_id], previlege_modular_id)
					if previlege.empty?
						@previlege = Previlege.new(previlege_params) 			
						@previlege.role_id = params[:previlege][:role_id]
						@previlege.modular_id = previlege_modular_id
						@previlege.save
					end
			end
				respond_to :js
		end
		
		def edit
			@previlege = Previlege.where('id= ?', params[:id]).first
			@section = ["Audit"]
			@role_previlege = Previlege.where('role_id= ?', @previlege.role_id)
		end
		
		def update
				params[:previlege][:modular_id].reject(&:empty?).each do |controller_name| 
				modular_id = Modular.where('modal_name =?', controller_name).first.id
				p @previlege = Previlege.where('role_id =? AND modular_id =?',  params[:previlege][:role_id], modular_id).first
				if @previlege.nil?
				Previlege.create(:role_id => params[:previlege][:role_id], :modular_id => modular_id)
				end
			end
		end
		
		
		
		#To get modular record based on section select
		def  modal_previlege
		  modular_id = Modular.where('section_id =?', params[:modal_id])
			render json: {:actions=>modular_id}
		end
		
		private
			
      def previlege_params
        params.require(:previlege).permit(:role_id, :modular_id)
			end
			#check current user is role
       def check_role
        role = Role.where('id =?', current_user.role_id).first.title if current_user.role_id.present?
         if role == 'company admin'
          return true
         else
           redirect_to '/users/sign_in'
         end
       end
			 #To check company roles for previleges
		 def role_company
			if current_user.company.roles.collect {|x| x.id}.include?(params[:role_id].to_i)
				return true
			else
				redirect_to admin_roles_path
			end
		 end
	end
  
	
	
	#display the required fields in index
  index do                            
    column :role_id        
    actions    
  end  

	#render form for create & edit previleges
	form :partial => "form"
   

end
