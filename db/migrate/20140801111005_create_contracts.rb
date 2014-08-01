class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :company_id
      t.integer :contract_type_id
      t.integer :contract_status_id
      t.string :name
      t.string :manufacturer
      t.datetime :start_date
      t.datetime :end_date
      t.integer :location_id
      t.integer :department_id
      t.text :notes

      t.timestamps
    end

    add_index :contracts, :company_id
    add_index :contracts, :location_id
    add_index :contracts, :department_id
    add_index :contracts, :contract_type_id
    add_index :contracts, :contract_status_id
  end
end
