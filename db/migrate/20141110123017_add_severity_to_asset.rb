class AddSeverityToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :severity, :string
  end
end
