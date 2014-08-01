class CreateLifecycles < ActiveRecord::Migration
  def change
    create_table :lifecycles do |t|
      t.integer :other_asset_id
      t.date :lifecycle_date
      t.integer :lifecycle_type_id
      t.integer :user_id
      t.text :notes

      t.timestamps
    end

    add_index :lifecycles, :other_asset_id
    add_index :lifecycles, :lifecycle_type_id
    add_index :lifecycles, :user_id

  end
end
