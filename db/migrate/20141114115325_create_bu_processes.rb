class CreateBuProcesses < ActiveRecord::Migration
  def change
    create_table :bu_processes do |t|
      t.integer :company_id
      t.string :name

      t.timestamps
    end
  end
end
