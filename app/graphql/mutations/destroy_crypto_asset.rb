# frozen_string_literal: true

module Mutations
  class DestroyCryptoAsset < BaseMutation
    argument :id, ID, required: true

    type Types::CryptoAsset

    def resolve(**params)
      ::Mutations::Resolvers::CryptoAsset.new(**params).destroy
    end
  end
end
