class AddPositionToOpinions < ActiveRecord::Migration[5.0]
  def up
    add_column :opinions, :position, :integer
  end

  def down
    remove_column :opinions, :position
  end
end
