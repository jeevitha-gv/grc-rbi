ActiveAdmin.register DistributionList do

  menu :if => proc{ !current_admin_user.present? }
  
  permit_params :name, :email_ids,:email_list,:company_id

  controller do
    before_filter :check_company_admin, :check_role
    before_filter :check_subdomain
    before_filter :check_plan_expire
    action :all, except: [:new, :show]

    #publicactivity gem
   
    def create
      @list = DistributionList.new(distribution_list_params)
      @list.company_id = current_user.company_id
      if @list.save
        redirect_to admin_distribution_lists_path
      else
        render new_admin_distribution_list_path
      end
    end
  
    private
      def distribution_list_params
        params.require(:distribution_list).permit(:name, {:email_ids => []}, :email_list, :company_id )
      end
  end
   #authentication


  index do
    selectable_column
    column :name
    column :email_list
    actions
  end

  show do
    attributes_table :name,:email_list
  end

  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs "Distribution Details" do
      f.input :name
      f.input :email_list
    end
    f.actions
  end
end
