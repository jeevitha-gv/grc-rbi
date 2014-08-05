class CreateEscalations < ActiveRecord::Migration
  def change
    create_table :escalations do |t|

      t.timestamps
    end
  end
end
