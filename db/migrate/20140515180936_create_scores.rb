class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :level
      t.string :description
      t.timestamps
    end
      Score.create([{level: '0', description: '0%'}])
      Score.create([{level: '1', description: '>0% - 50%'}])
      Score.create([{level: '2', description: '>50% - 70%'}])
      Score.create([{level: '3', description: '>70% - 90%'}])
      Score.create([{level: '4', description: '>90% - 100%'}])
  end
end
