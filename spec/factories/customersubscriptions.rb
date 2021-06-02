FactoryBot.define do
  factory :customersubscription do
    customer { "" }
    subscription { nil }
    status { 1 }
  end
end
