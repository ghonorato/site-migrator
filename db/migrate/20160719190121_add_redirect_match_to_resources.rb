class AddRedirectMatchToResources < ActiveRecord::Migration[5.0]
  def change
    change_table :resources do |t|
      t.column :redirect_match_id, :integer, index: true
    end
  end
end
