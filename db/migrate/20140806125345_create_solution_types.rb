class CreateSolutionTypes < ActiveRecord::Migration
  def change
    create_table :solution_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
