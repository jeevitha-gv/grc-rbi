ActiveAdmin.register FraudType do

  
permit_params :name
  breadcrumb do
      [
        link_to('FraudType', '/admin/fraud_types')
      ]
    end
      menu :if => proc{ !current_admin_user.present? }
  index do
    column "Name", :name
  end
  
end
