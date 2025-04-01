# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def initialize(context:)
      @context = context
      @current_user = context[:current_user]
    end

    private

    attr_reader :context, :current_user
  end
end
