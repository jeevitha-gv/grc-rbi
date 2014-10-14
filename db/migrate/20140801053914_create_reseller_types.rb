class CreateResellerTypes < ActiveRecord::Migration
  def change
    create_table :reseller_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
