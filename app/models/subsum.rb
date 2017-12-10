class Subsum < ApplicationRecord
  belongs_to :product
  belongs_to :token

  validates :token_id, uniqueness: { scope: :product_id,
      message: 'Should be one subsum from one device for single product'}
end