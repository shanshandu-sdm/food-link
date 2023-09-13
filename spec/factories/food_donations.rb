FactoryBot.define do
  factory :food_donation do
    quantity { 10 }
    status { :available }
    note { 'meat' }
    available_at { '2000-01-01 11:11:11' }
    user
    factory :requested_donation do
      status { :requested }
      charity_id { charity.id }
    end
  end
end
