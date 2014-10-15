class CreateCloseStatuses < ActiveRecord::Migration
  def change
    create_table :close_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
