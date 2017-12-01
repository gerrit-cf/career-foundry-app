require 'rails_helper'

describe ProductsController do
  let(:user) { create :user }

  subject { response }

  before { sign_in user }

  describe 'GET #index' do
    context 'without a search parameter' do
      before { get '/products' }

      it { is_expected.to be_successful }
    end

    context 'with a search parameter' do
      before { get '/products', params: { search_term: 'Bike XY' } }

      it { is_expected.to be_successful }
    end
  end

  describe 'GET #show' do
    let(:product) { create :product }

    before { get "/products/#{product.id}" }

    it { is_expected.to be_successful }
  end

  describe 'GET #new' do
    before { get '/products/new' }

    it { is_expected.to_not be_successful }
  end

  describe 'GET #edit' do
    let(:product) { create :product }

    before { get "/products/#{product.id}/edit" }

    it { is_expected.to_not be_successful }
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
      context 'with valid params' do
        it do
          expect do
            post '/products', params: { product: attributes_for(:product) }
          end.to change(Product, :count).by(1)
        end
      end

      context 'with invalid prams' do
        let(:product_params) { attributes_for(:product).merge(name: nil) }

        it do
          expect do
            post '/products', params: { product: product_params }
          end.to_not change(Product, :count)
        end
      end
    end

    describe 'PUT #update' do
      let(:product) { create :product, name: 'Foo' }

      context 'with valid params' do
        it do
          expect do
            put "/products/#{product.id}", params: { product: { name: 'Bar' } }
          end.to change { product.reload.name }.from('Foo').to('Bar')
        end
      end

      context 'with invalid params' do
        it do
          expect do
            put "/products/#{product.id}", params: { product: { name: nil } }
          end.to_not change { product.reload.name }
        end
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
