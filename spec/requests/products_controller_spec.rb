require 'rails_helper'

describe ProductsController do
  let(:user) { create :user }

  subject { response }

  before { sign_in user }

  describe 'GET #index' do
    before { get '/products' }

    it { is_expected.to be_successful }
  end

  describe 'GET #show' do
    let(:product) { create :product }

    before { get "/products/#{product.id}" }

    it { is_expected.to be_successful }
  end

  describe 'POST #create' do
    it 'does not create a product' do
      expect do
        post '/products', params: { product: attributes_for(:product) }
      end.to_not change(Product, :count)
    end
  end

  describe 'PUT #update' do
    let(:product) { create :product, name: 'Foo' }

    it do
      expect do
        put "/products/#{product.id}", params: { product: { name: 'Bar' } }
      end.to_not change { product.reload.name }
    end
  end

  describe 'DELETE #destroy' do
    let!(:product) { create :product }

    it do
      expect do
        delete "/products/#{product.id}"
      end.to_not change(Product, :count)
    end
  end

  context 'with an admin' do
    let(:user) { create :user, :admin }

    describe 'POST #create' do
      it do
        expect do
          post '/products', params: { product: attributes_for(:product) }
        end.to change(Product, :count).by(1)
      end
    end

    describe 'PUT #update' do
      let(:product) { create :product, name: 'Foo' }

      it do
        expect do
          put "/products/#{product.id}", params: { product: { name: 'Bar' } }
        end.to change { product.reload.name }.from('Foo').to('Bar')
      end
    end

    describe 'DELETE #destroy' do
      let!(:product) { create :product }

      it do
        expect do
          delete "/products/#{product.id}"
        end.to change(Product, :count).from(1).to(0)
      end
    end
  end
end
