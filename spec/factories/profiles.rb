FactoryBot.define do
  factory :profile do
    addr_line_1 { '123 Main St' }
    addr_line_2 { '#666' }
    city { 'Atlanta' }
    state { 'Georgia' }
    zip { '30018' }
    phone_number { '1233210000' }
    name {'FiveGuys'}
    user
  end
end
