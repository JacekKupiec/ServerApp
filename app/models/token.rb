class Token < ApplicationRecord
  belongs_to :user
  has_many :subsum, dependent: :destroy

  validates :token, presence: true, uniqueness: true
  validates :token_expiration_date, presence: true
  validates :refresh_token, presence: true, uniqueness: true
  validates :refresh_token_expiration_date, presence: true
end