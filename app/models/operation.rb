class Operation < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :name, presence: true, length: { minimum: 3 }
  validates :categories, presence: true, length: { minimum: 1 }
end
