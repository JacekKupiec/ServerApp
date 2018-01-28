class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :tokens, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :password_hash, presence: true
end
