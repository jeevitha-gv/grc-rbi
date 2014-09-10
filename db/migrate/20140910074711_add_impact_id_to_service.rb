class AddImpactIdToService < ActiveRecord::Migration
  def change
    add_column :services, :impact_id, :integer
  end
end
