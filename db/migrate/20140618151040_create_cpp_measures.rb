class CreateCppMeasures < ActiveRecord::Migration
  def change
    create_table :cpp_measures do |t|
      t.string :name
      t.string :description
      t.string :type
      t.integer :implementation_status_id
      t.integer :compliance_id
      t.integer :duration
      t.integer :company_id

      t.timestamps
    end
  end
end
