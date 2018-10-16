# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Evento #{n}" }
  end
end
