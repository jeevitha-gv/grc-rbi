class CreateIncidentPriorities < ActiveRecord::Migration
  def change
    create_table :incident_priorities do |t|
      t.string :name

      t.timestamps
    end
  end
end
