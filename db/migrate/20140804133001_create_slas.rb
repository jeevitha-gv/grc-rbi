class CreateSlas < ActiveRecord::Migration
  def change
    create_table :slas do |t|

      t.timestamps
    end
  end
end
