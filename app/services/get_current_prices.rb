# frozen_string_literal: true

class GetCurrentPrices
  include Callable
  include HTTParty
  base_uri 'https://api.coingecko.com/api/v3/simple/price'

  def initialize(symbols)
    @symbols = Array(symbols)
  end

  attr_reader :symbols

  def call
    Rails.cache.fetch("crypto_prices/#{symbols.join(',')}", expires_in: 5.minutes) do
      response = self.class.get("?ids=#{symbols.join(',')}&vs_currencies=usd")
      response.parsed_response
    rescue StandardError => e
      Rails.logger.error("GetCurrentPrice Error: #{e.message}")
    end
  end
end
