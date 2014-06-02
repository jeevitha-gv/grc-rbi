class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string :name
      t.integer :compliance_library_id
      t.integer :company_id

      t.timestamps
    end
  end
end
