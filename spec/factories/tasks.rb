FactoryGirl.define do
    factory :task do
        url 'https://www.c-date.dk/'
        email 'someemail@gmail.com'
        password '12345678'
        message 'Hi'
    end
end
