class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :photo_url
      t.integer :hour_price

      t.timestamps
    end
  end
end
