# frozen_string_literal: true

FactoryBot.define do
  name = Faker::RickAndMorty.character

  factory :admin do
    provider 'email'
    sequence(:name) { name }
    password 'ggc@1234'
    sequence(:email) { "#{name.downcase.tr(' ', '_')}@ggclabs.com.br" }
  end
end
