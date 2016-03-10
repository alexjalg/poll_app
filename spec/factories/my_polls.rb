FactoryGirl.define do
  factory :my_poll do
    association :user, factory: :sequence_user
    expires_at "2016-02-22 00:47:49"
    title "MyStringaaaa"
    description "MyTextaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    factory :poll_with_questions do
      title "Poll with questions"
      description "MyTextaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      questions { build_list :question, 2 }
    end
  end
end
