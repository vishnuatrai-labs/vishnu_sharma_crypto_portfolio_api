# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CryptoAsset, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:symbol) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:purchase_price) }
  it { should validate_numericality_of(:quantity) }
  it { should validate_numericality_of(:purchase_price) }
  it { should validate_numericality_of(:current_price) }

  context 'when validate uniqueness' do
    before { create(:crypto_asset) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_uniqueness_of(:symbol).case_insensitive }
  end
end
