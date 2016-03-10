FactoryGirl.define do
  factory :question do
    description "Aprendes rapido??.........."
    association :my_poll, factory: :my_poll
  end
end
