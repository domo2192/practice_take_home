FactoryBot.define do
  factory :customertea do
    customer { nil }
    tea { nil }
    rating { 1.5 }
    review { "MyText" }
  end
end
