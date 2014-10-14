class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :asset_id
      t.text :labelling
      t.text :disposal
      t.text :transport
      t.text :storage
      t.text :addressing
      t.text :assessment
      t.text :conclusion

      t.timestamps
    end
  end
end
