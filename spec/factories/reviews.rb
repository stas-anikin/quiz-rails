FactoryBot.define do
  factory :review do
    body { Faker::Hipster.sentence }
  end
end
