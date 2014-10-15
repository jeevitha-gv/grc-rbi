class CreateClosureClassifications < ActiveRecord::Migration
  def change
    create_table :closure_classifications do |t|
      t.string :name

      t.timestamps
    end
  end
end
