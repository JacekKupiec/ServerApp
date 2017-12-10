class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :tokens, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :password_hash, presence: true

  def self.find_by_access_token(token)

  end

  def self.find_by_refresh_token(token)

  end
end
