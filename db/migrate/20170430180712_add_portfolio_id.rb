class AddPortfolioId < ActiveRecord::Migration[5.0]
  def up
    add_column :projects, :portfolio_id, :integer
  end

  def down
    remove_column :projects, :portfolio_id
  end
end
