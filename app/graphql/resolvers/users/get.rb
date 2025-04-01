# frozen_string_literal: true

module Resolvers
  module Users
    class Get < ::Resolvers::BaseResolver
      def all
        ::User.all
      end
    end
  end
end
