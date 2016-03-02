FactoryGirl.define do
  factory :token do
    expires_at "2016-02-15 20:41:18"
    association :user, factory: :user
  end
end
