class CreatePurposeControls < ActiveRecord::Migration
  def change
    create_table :purpose_controls do |t|
      t.string :name

      t.timestamps
    end
  end
end
