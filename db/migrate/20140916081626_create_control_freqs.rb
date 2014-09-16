class CreateControlFreqs < ActiveRecord::Migration
  def change
    create_table :control_freqs do |t|
      t.string :name
      t.timestamps
    end
  end
end
