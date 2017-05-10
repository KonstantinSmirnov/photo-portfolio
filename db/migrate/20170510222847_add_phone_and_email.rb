class AddPhoneAndEmail < ActiveRecord::Migration[5.0]
  def up
    add_column :settings, :contact_phone, :string
    add_column :settings, :contact_email, :string
    add_column :settings, :facebook, :string
  end

  def down
    remove_column :settings, :contact_email
    remove_column :settings, :contact_phone
    remove_column :settings, :facebook
  end
end
