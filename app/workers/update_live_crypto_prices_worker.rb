# frozen_string_literal: true

class UpdateLiveCryptoPricesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform; end
end
