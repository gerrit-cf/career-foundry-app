require 'rails_helper'

describe RegistrationController do
  describe 'POST #create' do
    context 'with valid params' do
      it do
        expect do
          post '/sign_up', params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post '/sign_up', params: { user: attributes_for(:user).except(:email) }
        end.to_not change(User, :count)
      end
    end
  end
end
