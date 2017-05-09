class AddCategoryToProject < ActiveRecord::Migration[5.0]
  def up
    add_column :projects, :category_id, :integer
  end

  def down
    remove_column :projects, :category_id
  end
end
