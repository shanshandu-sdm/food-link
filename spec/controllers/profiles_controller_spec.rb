require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:restaurant) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  describe 'GET #edit' do
    it 'should return a edit page' do
      get :edit
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          addr_line_1: '1st st',
          addr_line_2: '202',
          city: 'Jersey City',
          state: 'NJ',
          zip: '77777',
          phone_number: '666',
          name: 'Leo'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { id: user.profile.to_param, profile: new_attributes }
        expect(user.profile.reload.name).to eq 'Leo'
      end
    end
  end
end
