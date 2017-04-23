class AddAccessTokenToInstagram < ActiveRecord::Migration[5.0]
  def up
    add_column :instagrams, :access_token, :string
    add_column :instagrams, :username, :string
    add_column :instagrams, :profile_picture, :string
  end

  def down
    remove_column :instagrams, :access_token
    remove_column :instagrams, :username
    remove_column :instagrams, :profile_picture
  end
end
