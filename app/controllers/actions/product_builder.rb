require 'securerandom'


class ProductBuilder
  def self.build_product_for_user(usr, tok, params)
    product = usr.products.build(params.require(:product).permit(:name, :store_name, :price, :guid))
    product.guid = SecureRandom.uuid if product.guid.blank?
    product.subsums << Subsum.new(subtotal: 0) #Rezerwowy subtotal, który nie jest związany z tokenem

    subsum = product.subsums.build params.require(:product).permit(:amount)
    subsum.token = tok

    return product
  end


end