class CreateBcStatuses < ActiveRecord::Migration
  def change
    create_table :bc_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
