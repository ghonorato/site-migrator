class DeleteTableSites < ActiveRecord::Migration[5.0]
  def change

    change_table :migrations do |t| 
      t.column :from_url, :string
      t.column :to_url, :string
      t.remove :new_site_id
      t.remove :current_site_id
    end

    change_table :resources do |t|
      t.column :type, :string
      t.references :migration, index: true
      t.remove :site_id
    end

    drop_table :sites
  end
end
