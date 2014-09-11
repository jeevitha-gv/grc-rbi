class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :company_id
      t.integer :assetable_id
      t.string :assetable_type
      t.string :name
      t.text :description
      t.integer :asset_state_id
      t.integer :owner_id
      t.integer :custodian_id
      t.integer :identifier_id
      t.integer :evaluated_by
      t.boolean :personal_data
      t.boolean :sensitive_date
      t.boolean :customer_data
      t.integer :confidentiality
      t.integer :availability
      t.integer :integrity
      t.integer :classification_id
      t.integer :department_id
      t.integer :location_id

      t.timestamps
    end
  end
end
