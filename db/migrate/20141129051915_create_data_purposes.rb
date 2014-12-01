class CreateDataPurposes < ActiveRecord::Migration
  def change
    create_table :data_purposes do |t|
      t.string :name

      t.timestamps
    end
  end
end
