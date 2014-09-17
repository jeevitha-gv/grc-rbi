class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :document_status_id
      t.integer :document_type_id
      t.float :version
      t.datetime :assigned_on

      t.timestamps
    end
    add_index :documents, :document_status_id
    add_index :documents, :document_type_id    
  end
end
