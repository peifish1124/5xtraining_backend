FactoryBot.define do
    factory :task do
        association :user, factory: :user
        title {'title'}
        content {'content'}
        status {'ongoing'}
        priority {2}
        start_time {'2022-03-18 00:00:00'}
        end_time {'2022-03-19 00:00:00'}
        created_at {'2022-03-17 00:00:00'}
    end
end