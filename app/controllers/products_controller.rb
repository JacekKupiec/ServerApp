require 'product_builder'

class ProductsController < ApplicationController
  rescue_from ArgumentError, with: :bad_parameters

  #Dodaję tylko wtedy gdy nie mam jeszcze produktu o zadanym GUID
  #Może się zdarzyć tak,że klient nie otrzyma potwierdzenia ,że obiekt został utworzony
  def add_product
    @token = get_token
    @user = get_user
    @product = ProductBuilder.build_product_for_user(@user, @token, params)
    found_product = Product.find_by(guid: @product.guid)

    if found_product.present?
      render json: { id: found_product.id }, staus: :ok
    elsif @product.save
      render json: { id: @product.id }, staus: :ok
    else
      render json: @product.errors.messages, status: :bad_request
    end
  end

  def delete_product
    @user = get_user
    id = Integer(params[:id])

    if @user.products.ids.include?(id)
      Product.find(params[:id]).destroy
      render json: { message: 'Product have been deleted' }, status: :ok
    else
      render json: { message: 'Deleted previously'}, status: :ok
    end
  end

  def decrease_amount
    @product = get_product
    @subsum = get_subsum @product
    delta = Integer(params[:delta])

    if get_user.products.ids.include?(@product.id)
      @subsum.subtotal -= delta if delta >= 0

      if @subsum.save
        render json: { amount: @product.total_sum }, status: :ok
      else
        render json: @subsum.errors.messages, status: :bad_request
      end
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Change account"'
      render json: { message: 'No permission to decrease amount of that product'},
             status: :unauthorized
    end
  end

  def increase_amount
    @product = get_product
    @subsum = get_subsum @product
    delta = Integer(params[:delta])

    if get_user.products.ids.include?(@product.id)
      @subsum.subtotal += delta if delta >= 0

      if @subsum.save
        render json: { amount: @product.total_sum }, status: :ok
      else
        render json: @subsum.errors.messages, status: :bad_request
      end
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Change account"'
      render json: { message: 'No permission to increase amount of that product'},
             status: :unauthorized
    end
  end

  def show
    @product = get_product

    if get_user.products.ids.include?(@product.id)
      render json: format_products(@product), status: :ok
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Change account"'
      render json: { message: 'No permission to get this product' },
             status: :unauthorized
    end
  end

  #Nieużywane, usunąć !!!
  def sync_subsum
    @product = get_product
    @subsum = get_subsum(@product)
    @subsum.subtotal = Integer(params[:subsum])

    if @subsum.save
      render json: { amount: @product.total_sum }, status: :ok
    else
      render json: @subsum.errors.messages, status: :bad_request
    end
  end

  private

  def bad_parameters
    render json: { message: 'Delta must be Integer' }, status: :bad_request
  end

  def get_subsum(product, subsum = 0)
    token = get_token

    return product.subsums.find_by(token: token) ||
        product.subsums.build(token: token, subtotal: subsum)
  end

  def get_token
    Token.find_by!(token: request.headers['Authorization'].split('=')[1])
  end

  def get_user
    get_token.user
  end

  def get_product
    Product.find(params[:id])
  end

  def format_products(product)
    hash = product.attributes.extract!('id', 'name', 'store_name', 'price', 'guid')
    hash[:amount] = product.total_sum

    return hash
  end
end
