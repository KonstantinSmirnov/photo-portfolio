class AddVisibleToBlog < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :visible, :boolean, default: false
  end
end
