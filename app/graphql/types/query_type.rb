# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :users, [Types::User], null: false
    field :crypto_assets, [Types::CryptoAsset], null: false

    def users
      ::Resolvers::Users::Get.new(context: context).all
    end

    def crypto_assets
      ::Resolvers::CryptoAssets::Get.new(context: context).all
    end
  end
end
