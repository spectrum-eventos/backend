# frozen_string_literal: true

class AdminSerializer
  FIELDS = %w[
    id
    name
    provider
    email
    created_at
    updated_at
  ].freeze

  def initialize(relation)
    @relation = relation
  end

  def serialize
    @relation.as_json(only: AdminSerializer::FIELDS)
  end

  def serialize_with_pagination(page)
    @relation = @relation.page(page) if page.present?

    {
      records: @relation.as_json(only: AdminSerializer::FIELDS),
      pagination: page.present? ? pagination : nil
    }
  end

  private

  def pagination
    {
      count: Admin.count,
      current_page: @relation.current_page,
      total_pages: @relation.total_pages,
      next_page: @relation.next_page,
      prev_page: @relation.prev_page,
      limit_value: @relation.limit_value,
      current_count: @relation.count
    }
  end
end
