class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.string :webpage_title
      t.text :seo_description
      t.text :seo_keywords
      t.text :seo_text

      t.timestamps
    end
  end
end
