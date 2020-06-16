class AddUrlPhotoToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :url_photo, :string, default: "https://img.freepik.com/icones-gratuites/info-logo-dans-cercle_318-947.jpg?size=338&ext=jpg"
  end
end
