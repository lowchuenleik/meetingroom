class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :venues

  validates :username, uniqueness: true, presence: true, length: { minimum: 6 }
  validates :name, presence: true
end
