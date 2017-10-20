require 'rails_helper'

describe StaticPagesController do
  subject { response }

  describe 'GET #index' do
    context 'with a valid page' do
      before { get '/about' }
      it { is_expected.to be_successful }
    end

    context 'with an invalid page' do
      before { get '/i_dont_exist' }

      it { is_expected.to_not be_successful }
    end
  end

  describe 'POST #contact' do
    let(:contact_params) do
      {
        name: 'Captain Obvious',
        email: 'captain.obvious@gmail.com',
        message: 'This is a request spec!'
      }
    end

    before do
      ContactMailer.deliveries.clear
    end

    it 'sends a mail' do
      expect do
        post '/contact', params: contact_params
      end.to change(ContactMailer.deliveries, :count).by(1)
    end
  end
end
