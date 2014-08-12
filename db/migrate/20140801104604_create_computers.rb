class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.integer :company_id
      t.string :name
      t.string :serial
      t.string :manufacturer
      t.string :ip
      t.integer :computer_category_id
      t.integer :asset_status_id
      t.integer :location_id
      t.integer :department_id
      t.integer :technical_contact
      t.integer :asset_owner

      t.timestamps
    end

    add_index :computers, :company_id
    add_index :computers, :computer_category_id
    add_index :computers, :asset_status_id
    add_index :computers, :location_id
    add_index :computers, :department_id
    add_index :computers, :technical_contact
    add_index :computers, :asset_owner

  end
end
