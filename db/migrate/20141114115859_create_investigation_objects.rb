class CreateInvestigationObjects < ActiveRecord::Migration
  def change
    create_table :investigation_objects do |t|
      t.text :name

      t.timestamps
    end
  end
end
