class Animal < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
  # validates :name, :description, :photo_url, :hour_price, presence: true
  
end
