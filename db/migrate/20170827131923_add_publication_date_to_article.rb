class AddPublicationDateToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :publication_date, :date
  end
end
