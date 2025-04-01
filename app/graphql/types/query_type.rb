# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :users, [Types::User], null: false

    def users
      ::Resolvers::Users::Get.new(context: context).all
    end
  end
end
