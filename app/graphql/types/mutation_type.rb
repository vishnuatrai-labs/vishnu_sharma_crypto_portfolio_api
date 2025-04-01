# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_crypto_asset, mutation: Mutations::CreateCryptoAsset
    field :update_crypto_asset, mutation: Mutations::UpdateCryptoAsset
    field :destroy_crypto_asset, mutation: Mutations::DestroyCryptoAsset
  end
end
