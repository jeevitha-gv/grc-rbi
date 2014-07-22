class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :section_id
      t.integer :company_id
      t.timestamps
    end

    add_index :teams, :section_id
    add_index :teams, :company_id
    
  end
end
