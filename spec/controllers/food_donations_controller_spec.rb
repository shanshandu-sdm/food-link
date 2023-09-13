require 'rails_helper'

# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe FoodDonationsController, type: :controller do
  let(:valid_attributes) do
    {
      quantity: 10, note: 'beef', available_at: '1999-09-09 09:11:30'
    }
  end

  let(:invalid_attributes) do
    {
    }
  end

  let(:restaurant) do
    create(:restaurant)
  end

  let(:charity) do
    create(:charity)
  end

  let(:food_donation) do
    create(:food_donation, user: restaurant)
  end

  describe 'GET #index' do\
    before do
      @request.env['devise.mapping'] = Devise.mappings[:restaurant]
      sign_in(restaurant)
    end
    it 'returns a success response' do
      get :index, format: :csv
      expect(response.header['Content-Type']).to include 'text/csv'
    end
  end
  #
  # describe "GET #show" do
  #   it "returns a success response" do
  #     food_donation = FoodDonation.create! valid_attributes
  #     get :show, params: {id: food_donation.to_param}, session: valid_session
  #     expect(response).to be_successful
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns a success response" do
  #     get :new, params: {}, session: valid_session
  #     expect(response).to be_successful
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns a success response" do
  #     food_donation = FoodDonation.create! valid_attributes
  #     get :edit, params: {id: food_donation.to_param}, session: valid_session
  #     expect(response).to be_successful
  #   end
  # end

  describe 'POST #create' do
    context 'sign in as restaurant' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:restaurant]
        sign_in(restaurant)
      end
      context 'with valid params' do
        it 'creates a new FoodDonation' do
          expect do
            post :create, params: { food_donation: valid_attributes }
          end.to change(FoodDonation, :count).by(1)
        end

        it 'redirects to the food_donation index' do
          post :create, params: { food_donation: valid_attributes }
          expect(response).to redirect_to(food_donations_path)
        end
      end

      context 'with invalid params' do
        it 'returns back to new FoodDonation with error' do
          post :create, params: { food_donation: invalid_attributes }
          expect(subject).to render_template('new')
        end
      end
    end

    context 'sign in with charity' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:charity]
        sign_in(charity)
      end
      it 'redirects to the root path' do
        post :create, params: { food_donation: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #request_donation' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:charity]
      sign_in(charity)
    end

    subject do
      get :request_donation, params: { id: food_donation.to_param }
    end

    it 'updates the status of food_donation to requested' do
      subject
      expect(assigns[:food_donation]['status']).to eq 'requested'
    end

    it 'adds charity id to food_donation' do
      subject
      expect(assigns[:food_donation]['charity_id']).to eq charity.id
    end

    it 'sends confirmation email to user' do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested food_donation" do
  #       food_donation = FoodDonation.create! valid_attributes
  #       put :update, params: {id: food_donation.to_param, food_donation: new_attributes}, session: valid_session
  #       food_donation.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "redirects to the food_donation" do
  #       food_donation = FoodDonation.create! valid_attributes
  #       put :update, params: {id: food_donation.to_param, food_donation: valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(food_donation)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'edit' template)" do
  #       food_donation = FoodDonation.create! valid_attributes
  #       put :update, params: {id: food_donation.to_param, food_donation: invalid_attributes}, session: valid_session
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested food_donation" do
  #     food_donation = FoodDonation.create! valid_attributes
  #     expect {
  #       delete :destroy, params: {id: food_donation.to_param}, session: valid_session
  #     }.to change(FoodDonation, :count).by(-1)
  #   end
  #
  #   it "redirects to the food_donations list" do
  #     food_donation = FoodDonation.create! valid_attributes
  #     delete :destroy, params: {id: food_donation.to_param}, session: valid_session
  #     expect(response).to redirect_to(food_donations_url)
  #   end
  # end
end
