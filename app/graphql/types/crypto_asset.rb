# frozen_string_literal: true

module Types
  class CryptoAsset < BaseObject
    field :id, ID, null: false
    field :username, type: String, null: false
    field :name, type: String, null: false
    field :symbol, type: String, null: false
    field :quantity, type: Int, null: false
    field :purchase_price, type: Float, null: false
    field :current_price, type: Float, null: false

    def username
      object.user.email
    end
  end
end
