Rails.application.routes.draw do
  authenticate :user do
    resources :food_donations do
      member do
        get :request_donation
        get :cancel
        get :complete
      end
    end

    resource :profile, only: [:edit, :update]
  end
  devise_scope :user do
    # to resolve devise conflicting behavior
    get '/users', to: redirect('/users/sign_up')
    get '/users/password', to: redirect('/users/password/new')
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'welcome/index'
  root 'welcome#index'
end
