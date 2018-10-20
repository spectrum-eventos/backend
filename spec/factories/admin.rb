# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    provider 'email'
    sequence(:name) { |n| "Admin #{n}" }
    password 'ggc@1234'
    sequence(:email) { |n| "admin#{n}@spctm.com" }
  end
end
