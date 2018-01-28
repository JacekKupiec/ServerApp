class Product < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :subsums, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :guid, presence: true, uniqueness: true

  def total_sum
    subsums.sum(:subtotal)
  end
end
