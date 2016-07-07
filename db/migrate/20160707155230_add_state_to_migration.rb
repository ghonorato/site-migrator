class AddStateToMigration < ActiveRecord::Migration[5.0]
  def change
    add_column :migrations, :state, :integer, default: Migration.states[:inputing_urls]
  end
end
