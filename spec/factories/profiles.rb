FactoryGirl.define do
    factory :profile do
        sequence(:profile_id) { |i| i.to_s }
        from_site 'https://www.c-date.co.uk/'
    end
end
