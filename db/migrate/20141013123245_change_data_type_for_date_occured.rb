class ChangeDataTypeForDateOccured < ActiveRecord::Migration
  def self.up
    change_table :incidents do |t|
      t.change :date_occured, :date
    end
  end
  def self.down
    change_table :incidents do |t|
      t.change :date_occured, :datetime
    end
  end
end
