FactoryGirl.define do
  factory :user do
    email "alexjalg@gmail.com"
    name "Alejandro"
    provider "github"
    uid "aa123as12sd15b9fg90"
    factory :dummy_user do
      email "alaura@gmail.com"
      name "Jose"
      provider "facebook"
      uid "aa123as12sd15b9fg90"
    end
    factory :sequence_user do
      sequence(:email) { |n| "person#{n}@example.com" }
      name "Jose"
      provider "facebook"
      uid "aa123as12sd15b9fg90"
    end
  end
end
