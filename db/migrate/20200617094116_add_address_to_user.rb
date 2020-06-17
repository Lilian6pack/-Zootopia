class AddAddressToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :string, default: Faker::Address.full_address
  end
end
