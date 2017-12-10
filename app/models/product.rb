class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :guid, presence: true
end
