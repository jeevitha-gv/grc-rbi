class CreateDistributionLists < ActiveRecord::Migration
  def change
    create_table :distribution_lists do |t|
      t.string :name
      t.string :email_ids, array: true, default: []
      t.integer :company_id
      t.timestamps
    end
  end
end
