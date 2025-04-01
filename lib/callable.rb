# frozen_string_literal: true

module Callable
  def self.included(base)
    base.extend ClassMethods
  end

  def call(*)
    raise NotImplementedError, "#{self.class}: call method not implemented"
  end

  module ClassMethods
    def call(...)
      new(...).call
    end
  end
end
