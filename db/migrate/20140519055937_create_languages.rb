class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    [
        { :name => 'English', :code => 'en' },
        { :name => 'French', :code => 'fr' }
    ].each do |l|
      Language.create(:name => l[:name], :code => l[:code])
    end
  end
end
