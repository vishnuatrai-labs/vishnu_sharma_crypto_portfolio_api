# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetCurrentPrices, type: :service do
  subject { described_class.call(symbols) }
  let(:symbols) { %w[bitcoin ethereum solana] }
  let(:cache_key) { "crypto_prices/#{symbols.join(',')}" }
  let(:api_response) { { 'bitcoin' => { 'usd' => 60_000 }, 'ethereum' => { 'usd' => 4000 }, 'solana' => { 'usd' => 3000 } } }

  before do
    Rails.cache.clear
    allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache::MemoryStore.new)
  end

  describe '#call' do
    context 'when API request is successful' do
      it 'fetches prices from the API and caches the response' do
        expect(Rails.cache).to receive(:fetch).with(cache_key, expires_in: 5.minutes).and_call_original
        expect(GetCurrentPrices).to receive(:get).with('?ids=bitcoin,ethereum,solana&vs_currencies=usd').and_return(double(parsed_response: api_response))

        expect(subject).to eq(api_response)
      end
    end

    context 'when the response is already cached' do
      before { Rails.cache.write(cache_key, api_response) }
      it 'returns cached data and does not call the API' do
        expect(GetCurrentPrices).not_to receive(:get)

        expect(subject).to eq(api_response)
      end
    end

    context 'when an API request fails' do
      before do
        allow(GetCurrentPrices).to receive(:get).and_raise(StandardError, 'API failure')
        allow(Rails.logger).to receive(:error)
      end

      it 'logs an error and does not raise an exception' do
        expect { subject }.not_to raise_error
        expect(Rails.logger).to have_received(:error).with(/GetCurrentPrice Error: API failure/)
      end
    end
  end
end
