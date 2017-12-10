class ProductsController < ApplicationController
  rescue_from ArgumentError, with: :bad_parameters

  def add_product
    @user = get_user
    @product = @user.products.build(params.require(:product).permit(:name, :store_name, :price, :amount))

    if @product.save
      render json: { id: @product.id }, staus: :ok
    else
      render json: @user.errors.messages.except!('updated_at', 'created_at'), status: :bad_request
    end
  end

  def delete_product
    @user = get_user
    id = Integer(params[:id])

    if @user.products.ids.include?(id)
      Product.find(params[:id]).destroy
      render json: { message: 'Product have been deleted' }, status: :ok
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { message: 'No permission to delete that product'}, status: :unauthorized
    end
  end

  def decrease_amount
    @product = get_product
    delta = Integer(params[:delta])

    if get_user.products.ids.include?(@product.id)
      @product.amount = [0, @product.amount - delta].max if delta > 0
      @product.save
      render json: { amount: @product.amount }, status: :ok
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { message: 'No permission to decrease amount of that product'}, status: :unauthorized
    end
  end

  def increase_amount
    @product = get_product
    delta = Integer(params[:delta])

    if get_user.products.ids.include?(@product.id)
      @product.amount += delta if delta > 0
      @product.save
      render json: { amount: @product.amount }, status: :ok
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { message: 'No permission to increase amount of that product'}, status: :unauthorized
    end
  end

  def show
    @product = get_product

    if get_user.products.ids.include?(@product.id)
      render json: @product.attributes.except!(:created_at, :updated_at)
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { message: 'No permission to get this product' }, status: :unauthorized
    end
  end

  private

  def bad_parameters
    render json: {message: 'Delta must be Integer' }, status: :bad_request
  end

  def get_user
    Token.find_by!(token: request.headers['Authorization'].split('=')[1]).user
  end

  def get_product
    Product.find(params[:id])
  end
end
