class CreateContractStatuses < ActiveRecord::Migration
  def change
    create_table :contract_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
