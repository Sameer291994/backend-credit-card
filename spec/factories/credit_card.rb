FactoryBot.define do
  factory :credit_card do
    name { Faker::Name.name }
    limit { Faker::Number.decimal(l_digits: 2) }
    card_number {"79927398713"}
  end
end
