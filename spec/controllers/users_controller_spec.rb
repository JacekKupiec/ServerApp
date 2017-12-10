require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it 'creates user from name and password' do
    post :create, :user => { name: 'jacek', password: 'ala ma kota' }
  end
end
