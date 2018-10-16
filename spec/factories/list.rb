# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    sequence(:name) { |n| "Chamada #{n}" }
  end
end
