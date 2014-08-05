class CreateIncidentImpacts < ActiveRecord::Migration
  def change
    create_table :incident_impacts do |t|
      t.string :name

      t.timestamps
    end
  end
end
