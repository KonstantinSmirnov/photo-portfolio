class CreateInstagrams < ActiveRecord::Migration[5.0]
  def change
    create_table :instagrams do |t|
      t.text :text

      t.timestamps
    end
  end
end
