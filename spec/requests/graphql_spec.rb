require 'rails_helper'

RSpec.describe 'Graphqls', type: :request do
  subject { post graphql_path, params: { query: query } }
  let(:query) do
    <<~GQL
      query {
        users {
          id
          email
         }
      }
    GQL
  end

  context 'when not logged in' do
    it 'returns an error' do
      subject
      expect(response.body).to eq('You need to sign in or sign up before continuing.')
    end
  end

  context 'when logged in' do
    let(:user) { create(:user) }
    before { sign_in user }
    let(:expected_response) { { 'email' => user.email, 'id' => user.id.to_s } }

    context 'when get users' do
      it 'returns users' do
        subject
        expect(JSON.parse(response.body)['data']['users']).to contain_exactly(expected_response)
      end
    end

    context 'when get crypto assets' do
      let(:query) do
        <<~GQL
          query {
            cryptoAssets {
              id
              username
              name
              symbol
              quantity
              purchasePrice
             }
          }
        GQL
      end
      let(:crypto_asset) { create(:crypto_asset, user: user) }
      before { crypto_asset }
      let(:expected_response) do
        { 'id' => crypto_asset.id.to_s, 'username' => user.email, 'name' => crypto_asset.name,
          'symbol' => crypto_asset.symbol, 'quantity' => crypto_asset.quantity.to_i,
          'purchasePrice' => crypto_asset.purchase_price.to_f }
      end

      it 'returns crypto assets' do
        subject
        expect(JSON.parse(response.body)['data']['cryptoAssets']).to contain_exactly(expected_response)
      end
    end

    context 'when create crypto assets' do
      let(:query) do
        <<~GQL
          mutation {
            createCryptoAsset(
             input: {#{' '}
                userId: #{user.id}
                name: "BTC"
                symbol: "bitcoin"
                quantity: 1
                purchasePrice: 100.11
              }
            ) {
              id
              name
              symbol
              quantity
              purchasePrice
            }
          }
        GQL
      end
      let(:expected_response) { { 'name' => 'BTC', 'symbol' => 'bitcoin', 'quantity' => 1, 'purchasePrice' => 100.11 } }

      it 'creates crypto assets for user' do
        expect { subject }.to change { CryptoAsset.count }.by(1)
        expect(JSON.parse(response.body)['data']['createCryptoAsset']).to a_hash_including(expected_response)
      end
    end

    context 'when update crypto assets' do
      let(:query) do
        <<~GQL
          mutation {
            updateCryptoAsset(
             input: {#{' '}
                id: #{crypto_asset.id}
                name: "BTC"
                symbol: "bitcoin"
              }
            ) {
              id
              name
              symbol
            }
          }
        GQL
      end
      let(:crypto_asset) { create(:crypto_asset, name: 'name1', symbol: 'sym1', user: user) }
      let(:expected_response) { { 'id' => crypto_asset.id.to_s, 'name' => 'BTC', 'symbol' => 'bitcoin' } }
      before { crypto_asset }

      it 'creates crypto assets for user' do
        expect { subject }.not_to(change { CryptoAsset.count })
        expect(JSON.parse(response.body)['data']['updateCryptoAsset']).to a_hash_including(expected_response)
      end
    end

    context 'when update crypto assets' do
      let(:query) do
        <<~GQL
          mutation {
            destroyCryptoAsset(
             input: {#{' '}
                id: #{crypto_asset.id}
              }
            ) {
              id
            }
          }
        GQL
      end
      let(:crypto_asset) { create(:crypto_asset, name: 'name1', symbol: 'sym1', user: user) }
      let(:expected_response) { { 'id' => crypto_asset.id.to_s } }
      before { crypto_asset }

      it 'creates crypto assets for user' do
        expect { subject }.to change { CryptoAsset.count }.by(-1)
        expect(JSON.parse(response.body)['data']['destroyCryptoAsset']).to a_hash_including(expected_response)
      end
    end
  end
end
