class AddSeoAttributesToResources < ActiveRecord::Migration[5.0]
  def change
    change_table :resources do |t| 
      t.column :title, :string
      t.column :meta_description, :string
      t.column :response_time, :float
      t.column :no_index, :boolean
      t.column :redirect_through, :string, array: true
      t.rename :http_code, :status_code
      reversible do |dir|
        dir.up { t.remove :content }
        dir.down { t.column :content, :text }
      end
    end
  end
end
