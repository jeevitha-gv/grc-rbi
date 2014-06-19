class CreateClassicScorings < ActiveRecord::Migration
  def change
    create_table :classic_scorings do |t|
      t.integer :likelihood
      t.integer :impact
      t.integer :velocity
      t.integer :vulnerability
      t.timestamps
    end
    
  add_index :classic_scorings, :likelihood, unique: true
  add_index :classic_scorings, :impact, unique: true
  add_index :classic_scorings, :velocity, unique: true
  add_index :classic_scorings, :vulnerability, unique: true
  end
end
