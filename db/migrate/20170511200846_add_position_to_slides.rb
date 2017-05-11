class AddPositionToSlides < ActiveRecord::Migration[5.0]
  def up
    add_column :hero_carousel_slides, :position, :integer
  end

  def down
    remove_column :hero_carousel_slides, :position
  end
end
