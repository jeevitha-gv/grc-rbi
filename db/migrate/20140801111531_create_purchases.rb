class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :other_asset_id
      t.string :order
      t.datetime :date
      t.string :total_cost
      t.integer :vendor_id
      t.text :notes

      t.timestamps
    end

    add_index :purchases, :other_asset_id
    add_index :purchases, :vendor_id
  end
end
