require 'factory_bot_rails'

FactoryBot.define do
  factory :movie do
    title {'A Fake Title'} # default values
    rating {'PG'}
    release_date { 10.years.ago }
    director {'director'}
  end
end