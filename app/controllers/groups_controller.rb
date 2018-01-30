class GroupsController < ApplicationController
  rescue_from ArgumentError, with: :bad_parameters

  def create
    @user = get_user
    @group = @user.groups.build(params.require(:group).permit(:name))

    if @group.save
      render json: { id: @group.id }, status: :created
    else
      render json: @group.errors.messages, status: :bad_request
    end
  end

  def delete
    @user = get_user
    id = Integer(params[:id])

    if @user.groups.ids.include?(id)
      Group.find(id).destroy
      render json: { message: 'Product have been deleted' }, status: :ok
    else
      render json: { message: 'Deleted previously'}, status: :ok
    end
  end

  def add_product
    @user = get_user
    group_id = Integer(params[:group_id])
    product_id = Integer(params[:product_id])

    if has_rights_to_group_and_product @user, group_id, product_id
      @group = Group.find group_id
      @product = Product.find product_id
      @product.group = @group

      if @product.save
        render json: { message: 'Product successfully added to group' }, status: :ok
      else
        render json: @product.error.messages, status: :bad_request
      end
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Change account"'
      render json: { message: 'No permission to add the product to the group'}, status: :unauthorized
    end
  end

  def remove_product
    @user = get_user
    group_id = Integer(params[:group_id])
    product_id = Integer(params[:product_id])

    if has_rights_to_group_and_product @user, group_id, product_id
      @product = Product.find product_id
      @product.group = nil

      if @product.save
        render json: { message: 'Product successfully removed from group' }, status: :ok
      else
        render json: @product.error.messages, status: :bad_request
      end
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Change account"'
      render json: { message: 'No permission to remove the product from the group'}, status: :unauthorized
    end
  end

  def get_group
    @user = get_user
    @group = Group.find params[:id]

    if @group.user == @user
      render json: { id: @group.id, name: @group.name }
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Change account"'
      render json: { message: 'No permission to get the group'}, status: :unauthorized
    end
  end

  private

  #Te 2 metody powinny trafić do osobnego modułu poniewaz sie powtarzają w 2 miejscach
  def get_token
    Token.find_by!(token: request.headers['Authorization'].split('=')[1])
  end

  def get_user
    get_token.user
  end

  def bad_parameters
    render json: { message: 'Delta must be Integer' }, status: :bad_request
  end

  def has_rights_to_group_and_product(usr, gid, pid)
    usr.groups.ids.include?(gid) && usr.products.ids.include?(pid)
  end
end
