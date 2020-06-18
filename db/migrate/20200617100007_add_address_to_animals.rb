class AddAddressToAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :address, :string
  end
end
