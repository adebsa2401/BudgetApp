class Category < ApplicationRecord
  attr_accessor :current_user

  has_and_belongs_to_many :operations
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 3 }

  def current_user_operations
    operations.where(author: current_user)
  end

  def total_amount
    current_user_operations.sum(:amount)
  end
end
