ActiveAdmin.register FraudType do
  config.filters = false
  menu :if => proc{ !current_admin_user.present? }

  breadcrumb do
      [
        link_to('FraudType', '/admin/fraud_types')
      ]
    end
      permit_params :company_id, :name
  index do
    column "Name", :name
  end
  
end
