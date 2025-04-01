# frozen_string_literal: true

class CryptoAsset < ApplicationRecord
  belongs_to :user

  validates :user, :name, :symbol, :quantity, :purchase_price, presence: true
  validates :name, :symbol, uniqueness: { case_sensitive: false }
  validates :quantity, :purchase_price, :current_price, numericality: true
end
