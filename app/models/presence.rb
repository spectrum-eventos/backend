# frozen_string_literal: true

class Presence < ApplicationRecord
  belongs_to :list
  validates :name, uniqueness: true
end
