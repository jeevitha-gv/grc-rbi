ActiveAdmin.register Client do

  menu :if => proc{ !current_admin_user.present? }

  permit_params :name, :company_id, :address1, :address2, :contact_no, :email

  controller do 
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
        params.require(:client).permit(:name, :address1, :address2, :contact_no, :email)
      end
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
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
