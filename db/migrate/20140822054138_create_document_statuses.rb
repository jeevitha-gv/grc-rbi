class CreateDocumentStatuses < ActiveRecord::Migration
  def change
    create_table :document_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
