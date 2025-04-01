# frozen_string_literal: true

class CreateCryptoAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :crypto_assets do |t|
      t.string :name
      t.string :symbol
      t.decimal :quantity
      t.decimal :purchase_price
      t.decimal :current_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
