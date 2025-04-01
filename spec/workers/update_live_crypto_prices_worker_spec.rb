# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateLiveCryptoPricesWorker do
  subject { described_class.new.perform }
  let(:crypto_asset) { create(:crypto_asset) }

  it 'updates live prices for all live cryptos' do
    expect(GetCurrentPrices).to receive(:call).and_return({ crypto_asset.symbol => { usd: 5000 } })
    expect { subject }.to change { crypto_asset.reload.current_price }.to(5000)
  end
end
