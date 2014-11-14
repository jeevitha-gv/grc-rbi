class CreateFindings < ActiveRecord::Migration
  def change
    create_table :findings do |t|
      t.text :name

      t.timestamps
    end
  end
end
