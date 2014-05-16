class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :section_id
      t.integer :company_id
      t.integer :department_id

      t.timestamps
    end
  end
end
