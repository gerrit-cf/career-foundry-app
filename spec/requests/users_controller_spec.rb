require 'rails_helper'

describe UsersController do
  let(:update_params) do
    {
      user: {
        password:              'newinsecurepassword',
        password_confirmation: 'newinsecurepassword'
      }
    }
  end

  subject { response }

  context 'when not logged in' do
    describe 'GET #show' do
      before { get '/user' }

      it { is_expected.to_not be_successful }
    end

    describe 'PUT #update' do
      before { put '/user', params: update_params }

      it { is_expected.to_not be_successful }
    end
  end

  context 'when logged in' do
    let(:user) { create :user }

    before { sign_in user }

    describe 'GET #show' do
      before { get '/user' }

      it { is_expected.to be_successful }
    end

    describe 'PUT #update' do
      it do
        expect do
          put '/user', params: update_params
        end.to change { user.reload.password_digest }
      end
    end
  end
end
