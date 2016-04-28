FactoryGirl.define do
  factory :user do
    sequence(:twitter_uid) { |n| "a#{rand(100..1000) + n}" }
    sequence(:twitter_user_name) { |n| "name#{n}" }
    sequence(:twitter_user_screen_name) { |n| "screen name#{n}" }
    twitter_token { SecureRandom.hex(10).encode('UTF-8') }
    twitter_secret { SecureRandom.hex(10).encode('UTF-8') }
    authentication_token { SecureRandom.hex(20).encode('UTF-8') }
    authentication_token_expires_at { 30.days.from_now }
  end
end
