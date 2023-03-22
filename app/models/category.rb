class Category < ApplicationRecord
  has_and_belongs_to_many :operations
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 3 }

  def total_amount
    operations.sum(:amount)
  end
end
