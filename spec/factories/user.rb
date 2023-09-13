FactoryBot.define do
  factory :user do
    email { 'test@gsu.com' }
    password { 'Pass123#*%($' }
    password_confirmation { password }
    confirmed_at { '2000-01-01 11:11:11' }

    after(:create) do |user, _evaluator|
      create(:profile, user: user)
    end

    factory :restaurant do
      email { 'restaurant@gsu.com' }
      role { :restaurant }
    end
    factory :charity do
      email { 'charity@gsu.com' }
      role { :charity }
    end
  end
end
