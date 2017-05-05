class CreateOpinions < ActiveRecord::Migration[5.0]
  def change
    create_table :opinions do |t|
      t.text :text
      t.string :author
      t.attachment :image

      t.timestamps
    end
  end
end
