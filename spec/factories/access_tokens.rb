# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_token do
    user nil
    token "MyString"
    expires_at "2014-05-21 18:35:21"
  end
end
