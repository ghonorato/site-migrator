class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :url
      t.integer :http_code
      t.string :redirect_location
      t.boolean :image
      t.references :site, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
