require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:existing_user) { create(:restaurant) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#create' do
    it 'should sign up a user and notice him to confirm email' do
      post :create, params: { user: { email: 'new' + existing_user.email, password: '12345678', password_confirmation: '12345678' } }
      expect(response).to redirect_to new_user_session_path
      expect(flash[:notice]).to eq 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      expect(assigns(:user)).to be_valid
    end

    it 'should not sign up a user with existing email' do
      post :create, params: { user: { email: existing_user.email, password: '12345678', password_confirmation: '12345678' } }
      expect(response).to have_http_status(200)
      expect(assigns(:user).errors.full_messages).to eq ["Email has already been taken"]
      expect(assigns(:user)).not_to be_valid
    end
  end
end
