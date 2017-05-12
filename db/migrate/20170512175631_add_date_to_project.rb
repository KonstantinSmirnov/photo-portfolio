class AddDateToProject < ActiveRecord::Migration[5.0]
  def up
    add_column :projects, :date, :date
    Project.all.each do |p|
      p.date = Time.now
      p.save!
    end
  end

  def down
    remove_column :projects, :date
  end
end
