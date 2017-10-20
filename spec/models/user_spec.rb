require 'rails_helper'

describe User do
  let(:user) { create :user }

  describe '#admin?' do
    subject { user.admin? }

    context 'with a non-admin user' do
      it { is_expected.to eq(false) }
    end

    describe 'with an admin user' do
      let(:user) { create :user, :admin }

      it { is_expected.to eq(true) }
    end
  end

  describe '#to_s' do
    subject { user.to_s }

    it { is_expected.to eq("#{user.first_name} #{user.last_name}") }
  end
end
