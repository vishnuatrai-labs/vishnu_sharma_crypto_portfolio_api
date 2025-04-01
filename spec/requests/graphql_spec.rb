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
  end
end
