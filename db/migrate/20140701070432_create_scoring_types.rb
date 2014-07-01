class CreateScoringTypes < ActiveRecord::Migration
  def change
    create_table :scoring_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
