class CreateAssetStates < ActiveRecord::Migration
  def change
    create_table :asset_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
