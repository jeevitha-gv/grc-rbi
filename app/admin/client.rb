ActiveAdmin.register Client do

  menu :if => proc{ !current_admin_user.present? }

  #permit_params :name, :company_id, :address1, :address2, :contact_no, :email
  
  controller do
    before_filter :check_company_admin
   action :all, except: [:new, :show]
    def scoped_collection  
     @client=Client.where('company_id= ?', current_user.company_id)
    end
    def create
      @client = Client.new(client_params)
      @client.company_id = current_user.company_id
      if @client.save
        redirect_to admin_clients_path
      else
        redirect_to new_admin_client_path
      end
    end

     private
    def client_params
      params.require(:client).permit(:name, :company_id, :address1, :address2, :contact_no, :email)
    end
  end
   #authentication
 

  index do
    column :name
    column :company_id
    column :address1
    column :address2
    column :contact_no
    column :email
    actions
  end
  form do |f|
    f.inputs "Clients Details" do
      f.input :name
      f.input :address1
      f.input :address2
      f.input :contact_no
      f.input :email
    end
    f.actions
  end
end
