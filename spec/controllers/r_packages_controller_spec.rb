require 'rails_helper'

RSpec.describe RPackagesController, type: :controller do
  before(:each) do
    RPackage.delete_all
    @package = RPackage.create(name: 'CBA')
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'handles search params' do
      get :index, search: 'cba'
      expect(response).to have_http_status(:success)
      expect(assigns(:r_packages)).to eq([@package])
    end

    it 'orders by name' do
      package_2 = RPackage.create(name: 'ABC')
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:r_packages)).to eq([package_2, @package])
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: @package.id
      expect(response).to have_http_status(:success)
    end
  end
end
