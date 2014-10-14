class CreateAssetDecisions < ActiveRecord::Migration
  def change
    create_table :asset_decisions do |t|
      t.string :name

      t.timestamps
    end
  end
end
