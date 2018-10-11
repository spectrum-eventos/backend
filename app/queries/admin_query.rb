# frozen_string_literal: true

class AdminQuery < BaseQuery
  def initialize(relation = Admin.all)
    @relation = relation
  end
end
