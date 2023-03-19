class Category < ApplicationRecord
  has_and_belongs_to_many :operations

  validates :name, presence: true, length: { minimum: 3 }
  validates :icon_url, presence: true

  def total_amount
    operations.sum(:amount)
  end
end
