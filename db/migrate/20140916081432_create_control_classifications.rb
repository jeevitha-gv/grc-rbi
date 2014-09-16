class CreateControlClassifications < ActiveRecord::Migration
  def change
    create_table :control_classifications do |t|
      t.string :name
      t.timestamps
    end
  end
end
