# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :lists, dependent: :destroy
end
