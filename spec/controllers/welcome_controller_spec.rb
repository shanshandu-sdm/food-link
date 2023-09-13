require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:user) { create(:restaurant) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  it 'should have a current_user after login' do
    get :index
    expect(subject.current_user).to_not eq(nil)
  end

  it 'should not have a current_user after logout' do
    get :index
    sign_out(user)
    expect(subject.current_user).to eq(nil)
  end
end
