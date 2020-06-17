class Animal < ApplicationRecord
  belongs_to :user
  has_one_attached :photo_url
  # validates :name, :description, :photo_url, :hour_price, presence: true
end
