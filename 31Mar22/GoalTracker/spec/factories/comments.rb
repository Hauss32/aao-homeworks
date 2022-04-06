FactoryBot.define do
    factory :comment do
        body { Faker::Lorem.sentences(number: 4).join(' ') }
    end
end