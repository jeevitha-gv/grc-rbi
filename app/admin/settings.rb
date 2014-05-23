ActiveAdmin.register Company, { :as => 'Settings'} do
  # scope_to :current_user
  menu :if => proc{ !current_admin_user.present? }
  # menu :url=> '/admin/settings/#{current_user.company_id}/edit'
  actions :all, :except => [:new, :create, :show, :destroy]
  config.filters = false
  config.batch_actions = false

  controller do
    before_filter :authorize_company, only: [:edit, :update]

    def index
      redirect_to edit_admin_setting_path(current_user.company_id)
    end

    def edit
      @company = current_user.company
    end

    def update
      @company.update_attributes(company_params)
      redirect_to edit_admin_setting_path(current_user.company_id)
    end

    private
    def company_params
      params.require(:settings).permit(:name, :secondary_email, :address1, :address2, :country_id, :contact_no, :timezone, attachment_attributes: [:attachment_file])
    end

    def authorize_company
      unless current_user.company_id == params[:id].to_i #(request.fullpath[1..-3] == "admin/settings" && current_user.company_id == params[:id].to_i)
        redirect_to root_subdomain_path
      end
    end
  end

  form do |f|
    f.inputs "Company Details" do
      f.input :name
      f.input :primary_email , :input_html => { :disabled => true }
      f.input :secondary_email
      f.input :domain , :input_html => { :disabled => true }
      f.input :address1
      f.input :address2
      # f.semantic_fields_for :attachment do |p|
      #   render :partial => "get_attachment"
      # end
      f.input :timezone, :as => :select, :collection => Company::TIMEZONES
      f.input :country
      f.input :contact_no
      f.input :is_disabled
    end
    f.actions
  end


  # index do
  #   redirect_to edit_admin_setting_path(current_user.company_id)
  # end

  # show do
  #   attributes_table :name, :primary_email, :secondary_email, :domain, :address1, :address2, :country_id, :contact_no, :timezone
  # end
end