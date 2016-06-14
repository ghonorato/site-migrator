class CreateMigrations < ActiveRecord::Migration[5.0]
  def change
    create_table :migrations do |t|
      t.string :name
      t.string :from_addres
      t.string :to_address

      t.timestamps
    end
  end
end
