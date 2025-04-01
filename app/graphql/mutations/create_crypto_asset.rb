# frozen_string_literal: true

module Mutations
  class CreateCryptoAsset < BaseMutation
    argument :user_id, ID, required: true
    argument :name, String, required: true
    argument :symbol, String, required: true
    argument :quantity, Int, required: true
    argument :purchase_price, Float, required: true

    type Types::CryptoAsset

    def resolve(**params)
      ::Mutations::Resolvers::CryptoAsset.new(**params).create
    end
  end
end
