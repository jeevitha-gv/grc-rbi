class CreateControlStatuses < ActiveRecord::Migration
  def change
    create_table :control_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
