FactoryBot.define do
  factory :user do
    account_id { 'test' }
    account_name { 'test' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
  end
end
