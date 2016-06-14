class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :url
      t.boolean :image
      t.string :origin
      t.references :migration, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
