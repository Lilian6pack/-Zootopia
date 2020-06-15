class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :zoo, :boolean, default: false
  end
end
