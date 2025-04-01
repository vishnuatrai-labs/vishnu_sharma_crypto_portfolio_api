# frozen_string_literal: true

module Resolvers
  module CryptoAssets
    class Get < ::Resolvers::BaseResolver
      def all
        ::CryptoAsset.where(user: current_user).all
      end
    end
  end
end
