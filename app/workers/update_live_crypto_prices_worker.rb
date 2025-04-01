# frozen_string_literal: true

class UpdateLiveCryptoPricesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(symbols = nil)
    symbols ||= CryptoAsset.pluck(:symbol).uniq
    prices = GetCurrentPrices.call(symbols)

    prices.each do |symbol, data|
      CryptoAsset.where(symbol: symbol).update_all(current_price: data.with_indifferent_access['usd'])
    end
  end
end
