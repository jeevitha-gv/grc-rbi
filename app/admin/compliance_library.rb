ActiveAdmin.register ComplianceLibrary do

  permit_params :compliance_id, :name, :is_leaf, :parent_id 
  
  #authentication for superadmin
  controller do
    before_filter :authenticate_admin_user!
  end
  
  #Index page fields customization
 index do
    selectable_column
    column :id
    column :name
    column "Compliance" do |compliance|
      compliance.compliance_name
    end
    column :is_leaf
    column "Parent" do |compliance_library|
      ComplianceLibrary.where('id= ?', compliance_library.parent_id).first.name if compliance_library.parent_id.present?
    end
    actions
  end
  
  #show page fields customization
  show do
    attributes_table do
      row :id
      row :name
      row "Compliance" do |compliance|
        compliance.compliance_name
      end
      row :is_leaf
      row "Parent" do |compliance_library|
        ComplianceLibrary.where('id= ?', compliance_library.parent_id).first.name if compliance_library.parent_id.present?
      end
      row :created_at
      row :updated_at
    end
  end
  
  #ComplianceLibrary creation form customization
  form do |f|
    f.inputs "ComplianceLibrary" do
      f.input :compliance_id, :as => :select, :collection => Compliance.all, :prompt => "-Select Compliance-"
      f.input :name
      f.input :is_leaf, :input_html => {
      #Enable parent selectionbox only if is_leaf is checked
      :onclick => "
        var leaf = $('#compliance_library_is_leaf').val();
        if($('#compliance_library_is_leaf').is(':checked')){
        $('#compliance_library_parent_id').attr('disabled', false);
        }
        else
        {
        $('#compliance_library_parent_id').val('');
        }
      "
      }
    f.input :parent_id,:as=>:select, :collection => ComplianceLibrary.all,:prompt => '-Select Compliance parent-', :input_html => {:disabled => true}
    end
    f.actions
  end
  
end
