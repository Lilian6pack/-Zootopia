class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :animals
  devise :database_authenticatable, :registerable,
  
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :name, :email, presence: true
  has_many :animals, dependent: :destroy
end
