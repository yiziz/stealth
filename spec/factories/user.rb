FactoryGirl.define do
  factory :user do
    login_name 'test_name'
    password 'aoeuaoe8'
    password_confirmation 'aoeuaoe8'
  end
  factory :norm_user, class: User, parent: :user do
    #role Role.find(1)
  end
end
