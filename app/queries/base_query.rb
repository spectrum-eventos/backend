# frozen_string_literal: true

class BaseQuery
  def method_missing(method_sym, *arguments, &block)
    if by_method?(method_sym)
      default_query(method_sym, arguments, block)
    elsif @relation.methods.include?(method_sym)
      @relation.send(method_sym, *arguments, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_sym, _include_private = false)
    if by_method? method_sym
      respond_to?(attribute(method_sym))
    else
      @relation.methods.include?(method_sym)
    end
  end

  private

  def klass
    self.class.name.to_s.gsub('Query', '').constantize
  end

  def by_method?(method_sym)
    method_sym.match(/^by_/).present?
  end

  def attribute(method_sym)
    method_sym.to_s.gsub(/^by_/, '').to_sym
  end

  def default_query(method_sym, *arguments)
    @relation.where(attribute(method_sym) => arguments.flatten)
  end
end
