class CreateCompliances < ActiveRecord::Migration
  def change
    create_table :compliances do |t|
      t.string :name

      t.timestamps
    end
    Compliance.create([{name: 'COBIT'}])
    Compliance.create([{name: 'FISMA'}])
    Compliance.create([{name: 'HIPAA'}])
    Compliance.create([{name: 'ISO 27001'}])
    Compliance.create([{name: 'ISO 28000'}])
    Compliance.create([{name: 'OSHAS'}])
    Compliance.create([{name: 'PCI DSS'}])
    Compliance.create([{name: 'SOX'}])
  end
end
