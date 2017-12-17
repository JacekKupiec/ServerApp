class Subsum < ApplicationRecord
  belongs_to :product
  belongs_to :token, optional: true

  validates :subtotal, numericality: { only_integer: true }
  validates :token_id, uniqueness: { scope: :product_id,
      message: 'Should be one subsum from one device for single product'}

  before_destroy :save_subtotal

  private

  def save_subtotal
    sub = product.subsums.find_by(token: nil)

    unless sub.nil?
      sub.subtotal += self.subtotal
      sub.save
    end
  end
end