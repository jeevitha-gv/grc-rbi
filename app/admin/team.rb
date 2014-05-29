ActiveAdmin.register Team do

      menu :if => proc{ !current_admin_user.present? }


 controller do
   before_filter :check_company_admin, :check_role
   action :all, except: [:new, :show]

    def scoped_collection
     @team=Team.where('company_id= ?', current_user.company_id)
    end

    def create
      @team = Team.new(team_params)
      @team.company_id = current_user.company_id
      if @team.save
        flash[:now]=  MESSAGES["Team"]["create"]["success"]
        redirect_to admin_teams_path
      else
        # redirect_to new_admin_team_path
        render 'new'
      end
    end

    private
      def team_params
        params.require(:team).permit(:name, :module_id, :company_id, :department_id)
      end
  end

  permit_params :name


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