# frozen_string_literal: true

Dir[File.join(__dir__, '../lib/*.rb')].each { |file| require file }
require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
