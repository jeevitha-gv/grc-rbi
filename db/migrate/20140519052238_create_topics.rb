class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name

      t.timestamps
    end

    Topic.create([{name: 'Network Security'}])
    Topic.create([{name: 'Physical Security'}])
    Topic.create([{name: 'System Security'}])
    Topic.create([{name: 'Access'}])
    Topic.create([{name: 'Applications'}])
    Topic.create([{name: 'Others'}])
  end
end
