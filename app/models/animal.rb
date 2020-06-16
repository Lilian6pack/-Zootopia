class Animal < ApplicationRecord
  belongs_to :user
  validates :name, :description, :photo_url, :hour_price, presence: true
end
