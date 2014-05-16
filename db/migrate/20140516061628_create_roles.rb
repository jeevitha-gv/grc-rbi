class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :title
      t.integer :company_id
      t.timestamps
    end
    Role.create([{title: 'company admin', company_id: 0}])
    Role.create([{title: 'company user', company_id: 0}])
    
  end
end
