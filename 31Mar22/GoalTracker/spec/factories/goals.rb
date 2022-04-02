FactoryBot.define do 
    factory :goal do
        title { Faker::Lorem.sentences(number: 1) }
        description { Faker::Lorem.sentences(number: 4) }
        is_complete { false }
        is_public { false }

        factory :public_complete_goal do
            is_complete { true }
            is_public { true }
        end

        factory :public_incomplete_goal do
            is_public { true }
        end

        factory :private_complete_goal do 
            is_complete { true }
        end
    end
end