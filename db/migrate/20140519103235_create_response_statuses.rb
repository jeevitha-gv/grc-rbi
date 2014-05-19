class CreateResponseStatuses < ActiveRecord::Migration
  def change
    create_table :response_statuses do |t|
      t.string :name

      t.timestamps
    end
    ResponseStatus.create([{name: 'Planning'}])
    ResponseStatus.create([{name: 'In Progress'}])
    ResponseStatus.create([{name: 'Halted'}])
    ResponseStatus.create([{name: 'Cancelled'}])
    ResponseStatus.create([{name: 'Completed'}])
  end
end
