class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :name

      t.timestamps
    end
  end
end
