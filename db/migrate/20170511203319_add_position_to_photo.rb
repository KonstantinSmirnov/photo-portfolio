class AddPositionToPhoto < ActiveRecord::Migration[5.0]
  def up
    add_column :photos, :position, :integer
  end

  def down
    remove_column :photos, :position
  end
end
