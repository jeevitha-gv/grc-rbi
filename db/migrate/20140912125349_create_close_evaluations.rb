class CreateCloseEvaluations < ActiveRecord::Migration
  def change
    create_table :close_evaluations do |t|
      t.string :name

      t.timestamps
    end
  end
end
