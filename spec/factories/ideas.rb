FactoryBot.define do
  factory :idea do
    title { Faker::Hipster.sentence }
    description { Faker::Hipster.paragraph }

    association(:user, factory: :user)
  end
end
