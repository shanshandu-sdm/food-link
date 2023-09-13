class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, password_length: 8..128

  validates :role, presence: true

  has_one :profile, dependent: :destroy
  has_many :food_donations, foreign_key: 'restaurant_id', dependent: :destroy
  accepts_nested_attributes_for :profile, :food_donations

  enum role: {
    admin: 0,
    restaurant: 1,
    charity: 2
  }
end
