# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_task do
    user
    task
    result -1
  end
end
