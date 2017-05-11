class AddPositionToCategory < ActiveRecord::Migration[5.0]
  def up
    add_column :categories, :position, :integer
  end

  def down
    remove_column :categories, :position
  end
end
