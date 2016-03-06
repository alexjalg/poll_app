FactoryGirl.define do
  factory :my_poll do
    association :user, factory: :sequence_user
    expires_at "2016-02-22 00:47:49"
    title "MyStringaaaa"
    description "MyTextaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  end
end
