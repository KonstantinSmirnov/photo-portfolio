class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.text :text
      t.attachment :image

      t.timestamps
    end
  end
end
