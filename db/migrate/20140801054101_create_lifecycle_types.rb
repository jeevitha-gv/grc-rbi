class CreateLifecycleTypes < ActiveRecord::Migration
  def change
    create_table :lifecycle_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
