class AddAttachmentToHeroCarousel < ActiveRecord::Migration[5.0]
  def up
    add_attachment :hero_carousel_slides, :image
  end

  def down
    add_attachment :hero_carousel_slides, :image
  end
end
