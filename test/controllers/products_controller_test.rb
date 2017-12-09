require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test 'can add product' do
    post :add_product, { product: { name: 'Borówka Basia', store_name: 'Biedronka', price: 6.79, amount: 2} }, { HTTP_AUTHORIZATION: "Token token=#{users(usr.token)}" }
    assert_response :created
  end

  test 'can remove product' do

  end

  test 'can increase amount' do

  end

  test 'can decrease amount' do

  end


end