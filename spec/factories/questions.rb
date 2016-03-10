FactoryGirl.define do
  factory :question do
    description "Aprendes rapido??..........ctm"
    association :my_poll, factory: :my_poll
  end
end
