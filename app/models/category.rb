class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :icon_url, presence: true
end
