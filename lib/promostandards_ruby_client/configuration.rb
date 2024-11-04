# frozen_string_literal: true

require "logger"

module PromostandardsRubyClient
  # The Configuration class provides a way to set up and manage configuration
  # options for the gem.
  #
  # == Usage
  #
  # Configuration can be set for the application in a Rails initializer:
  #
  #   # config/initializers/promostandards_ruby_client.rb
  #   PromostandardsRubyClient::Client.configure do |config|
  #     config.service_url = 'https://custom-service-url.com'
  #     config.logger = Rails.logger
  #   end
  #
  # Alternatively, configuration options can be passed directly when
  # creating an instance of the client:
  #
  #   client = PromostandardsRubyClient::Client.new(
  #     service_url: 'https://another-service-url.com',
  #     logger: custom_logger
  #   )
  #
  # == Attributes
  #
  # * +service_url+ - The base URL for the PromoStandards-compatible
  #   service.
  #
  # * +logger+ - A logger with an API compatible with Rails.logger (
  #   responding to +info+, +warn+, +error+, etc.). Defaults to a standard
  #   Logger instance outputting to STDOUT.
  #
  class Configuration
    # The base URL for the PromoStandards-compatible service.
    # This attribute is required; it must be set in either global
    # configuration or directly passed to the client instance. If not set,
    # an error will be raised.
    attr_accessor :service_url
    # A logger with an API compatible with Rails.logger (responding to
    # +info+, +warn+, +error+, etc.). Defaults to a standard Logger
    # instance outputting to STDOUT.
    attr_accessor :logger

    def initialize
      @logger = ::Logger.new($stdout)
    end
  end
end
