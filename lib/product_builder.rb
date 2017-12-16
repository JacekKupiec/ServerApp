require 'securerandom'

class ProductBuilder
  def self.build_product_for_user(usr, tok, params)
    product = usr.products.build(params.require(:product).permit(:name, :store_name, :price, :guid))
    product.guid = SecureRandom.uuid if product.guid.blank?
    product.subsums << Subsum.new(subtotal: 0) #Rezerwowy subtotal, który nie jest związany z tokenem

    subsum = product.subsums.build(subtotal: params[:product][:amount].to_i) #Jeśli pusty to 0
    subsum.token = tok

    return product
  end


end