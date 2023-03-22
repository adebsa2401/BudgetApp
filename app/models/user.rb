class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :operations, inverse_of: :author, foreign_key: :author_id

  validates :name, presence: true, length: { minimum: 3 }
end
