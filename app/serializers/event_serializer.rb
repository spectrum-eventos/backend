# frozen_string_literal: true

class EventSerializer
  FIELDS = %w[
    id
    name
    created_at
    updated_at
  ].freeze

  def initialize(relation)
    @relation = relation
    @size = relation.count if relation.methods.include?(:count)
  end

  def serialize
    @relation.as_json(only: EventSerializer::FIELDS)
  end

  def serialize_with_pagination(page)
    @relation = @relation.page(page) if page.present?

    {
      records: @relation.as_json(only: EventSerializer::FIELDS),
      pagination: page.present? ? pagination : nil
    }
  end

  private

  def pagination
    {
      count: @size,
      current_page: @relation.current_page,
      total_pages: @relation.total_pages,
      next_page: @relation.next_page,
      prev_page: @relation.prev_page,
      limit_value: @relation.limit_value,
      current_count: @relation.count
    }
  end
end
