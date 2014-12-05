class CreatePlanStatuses < ActiveRecord::Migration
  def change
    create_table :plan_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
