class AddAnalyticsField < ActiveRecord::Migration[5.0]
  def up
    add_column :settings, :analytics, :text
  end

  def down
    remove_column :settings, :analytics
  end
end
