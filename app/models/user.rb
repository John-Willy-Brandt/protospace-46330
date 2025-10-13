class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

validates :user_profile, presence: true, length: { maximum: 200 }
validates :user_name, presence: true
validates :user_occupation, presence: true
validates :user_position, presence: true

end
