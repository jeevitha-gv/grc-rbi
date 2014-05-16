ActiveAdmin.register Section do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  show do
  end

end
