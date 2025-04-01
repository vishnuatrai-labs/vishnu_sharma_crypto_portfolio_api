# frozen_string_literal: true

module Mutations
  class UpdateCryptoAsset < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :symbol, String, required: false
    argument :quantity, Int, required: false
    argument :purchase_price, Float, required: false
    argument :current_price, Float, required: false

    type Types::CryptoAsset

    def resolve(**params)
      ::Mutations::Resolvers::CryptoAsset.new(**params).update
    end
  end
end
