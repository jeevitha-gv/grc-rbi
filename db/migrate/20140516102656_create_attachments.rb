class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachment_file
      t.string :attachable_type
      t.references :attachable, index: true

      t.timestamps
    end
  end
end
