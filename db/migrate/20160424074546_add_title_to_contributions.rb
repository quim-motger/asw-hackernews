class AddTitleToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :title, :String
  end
end
