class CreateAssetActions < ActiveRecord::Migration
  def change
    create_table :asset_actions do |t|
      t.integer :asset_id
      t.text :custodian_actions

      t.timestamps
    end
  end
end
