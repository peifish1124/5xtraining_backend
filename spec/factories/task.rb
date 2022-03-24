FactoryBot.define do
    factory :task do
        association :user, factory: :user
        title {'task test'}
        content {'this is task test'}
        status {'進行中'}
        priority {2}
        tag {'test'}
        start_time {'2022-03-18 00:00:00'}
        end_time {'2022-03-19 00:00:00'}
        created_at {'2022-03-17 00:00:00'}
    end
end