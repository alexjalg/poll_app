FactoryGirl.define do
  factory :question do
    association :my_poll, factory: :my_poll
    description "Aprendes rapido??"
  end
end
