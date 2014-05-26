ActiveAdmin.register Team do

      menu :if => proc{ !current_admin_user.present? }

      # permit_params :name, :module_id, :company_id, :department_id
 controller do
   action :all, except: [:new, :show]
    def scoped_collection  
     @team=Team.where('company_id= ?', current_user.company_id)
    end
    def create
      @team = Team.new(team_params)
      @team.company_id = current_user.company_id
      if @team.save
        redirect_to admin_teams_path
      else
        redirect_to new_admin_team_path
      end
    end

     private
    def team_params
      params.require(:team).permit(:name, :module_id, :company_id, :department_id)
     end
  end

  index do
    selectable_column
    column :name
    actions
  end
form do |f|
    f.inputs "Team" do
      f.input :name
    end       
    f.actions
  end  

  
end
