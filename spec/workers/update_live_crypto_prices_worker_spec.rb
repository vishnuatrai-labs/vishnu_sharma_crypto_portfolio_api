# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateLiveCryptoPricesWorker do
  subject { described_class.new.perform }
end
