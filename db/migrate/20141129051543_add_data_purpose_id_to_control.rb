class AddDataPurposeIdToControl < ActiveRecord::Migration
  def change
    add_column :controls, :data_purpose_id, :integer
  end
end
