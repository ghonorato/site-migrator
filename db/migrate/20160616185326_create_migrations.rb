class CreateMigrations < ActiveRecord::Migration[5.0]
  def change
    create_table :migrations do |t|
      t.string :name
      t.references :current_site
      t.references :new_site
      
      t.timestamps
    end

    add_foreign_key :migrations, :sites, column: :current_site_id
    add_foreign_key :migrations, :sites, column: :new_site_id
  end
end
