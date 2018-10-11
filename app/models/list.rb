# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :event
  has_many :presences, dependent: :destroy
end
