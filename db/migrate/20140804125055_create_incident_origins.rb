class CreateIncidentOrigins < ActiveRecord::Migration
  def change
    create_table :incident_origins do |t|
      t.string :name

      t.timestamps
    end
  end
end
