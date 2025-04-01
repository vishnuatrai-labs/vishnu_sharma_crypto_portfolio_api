# frozen_string_literal: true

module Mutations
  module Resolvers
    class CryptoAsset
      def initialize(params)
        @params = params
      end

      attr_accessor :params

      def create
        params.update(user: user)
        params[:current_price] ||= params[:purchase_price]
        crypto_asset = ::CryptoAsset.create!(params)

        UpdateLiveCryptoPricesWorker.perform_async(crypto_asset.symbol) # update current price
        crypto_asset
      end

      def update
        id = params.delete(:id)
        crypto_asset = ::CryptoAsset.find(id)
        crypto_asset.update!(params)
        crypto_asset
      end

      def destroy
        id = params.delete(:id)
        crypto_asset = ::CryptoAsset.find(id)
        crypto_asset.destroy!
      end

      def user
        ::User.find(params[:user_id])
      end
    end
  end
end
