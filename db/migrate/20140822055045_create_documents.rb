class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.integer :impact_id
      t.integer :document_status_id
      t.integer :document_type_id
      t.float :version
      t.integer :location_id
      t.integer :department_id
      t.integer :asset_manager_id
      t.integer :asset_user_id
      t.datetime :assigned_on

      t.timestamps
    end
    add_index :documents, :document_status_id
    add_index :documents, :document_type_id
    add_index :documents, :location_id
    add_index :documents, :department_id
    add_index :documents, :asset_manager_id
    add_index :documents, :asset_user_id
  end
end
