# frozen_string_literal: true

require_relative "client/version"

module Promostandards
  module Ruby
    module Client
      # The Client class is the main entry point for interacting with the
      # PromoStandards API through the Promostandards::Ruby::Client gem.
      # This class provides flexible configuration options, allowing users
      # to specify the API service URL, logger, and other settings either
      # globally or per instance.
      #
      # == Configuration
      #
      # Configuration can be set globally across the application, typically
      # in a Rails initializer:
      #
      #   # config/initializers/promostandards_client.rb
      #   Promostandards::Ruby::Client.configure do |config|
      #     config.service_url = 'https://custom-service-url.com'
      #     config.logger = Rails.logger
      #   end
      #
      # Alternatively, options can be passed directly to an instance of the
      # Client:
      #
      #   client = Promostandards::Ruby::Client.new(
      #     service_url: 'https://another-service-url.com',
      #     logger: custom_logger
      #   )
      #
      # == Attributes
      #
      # * +service_url+ - The base URL for the PromoStandards-compatible
      #   service, set through global configuration or passed to the instance.
      #   Defaults to nil and raises an error if not set.
      #
      # * +logger+ - A logger object with an API compatible with Rails.logger,
      #   used for logging API interactions and other messages.
      #
      # == Example Usage
      #
      #   # Configure the client globally in a Rails initializer
      #   Promostandards::Ruby::Client.configure do |config|
      #     config.service_url = 'https://custom-service-url.com'
      #     config.logger = Rails.logger
      #   end
      #
      #   # Instantiate the client
      #   client = Promostandards::Ruby::Client.new
      #
      #   # Or override configuration settings at instance level
      #   options = { service_url: 'https://another-service-url.com' }
      #   client = Promostandards::Ruby::Client.new(options)
      #
      class Client
        class << self
          attr_accessor :configuration
        end

        # Allows global configuration of the Client class. When called with a
        # block, it yields an instance of Configuration, enabling settings like
        # +service_url+ and +logger+ to be set for the entire application.
        #
        # @example Configuring the client globally
        #   Promostandards::Ruby::Client.configure do |config|
        #     config.service_url = 'https://custom-service-url.com'
        #     config.logger = Rails.logger
        #   end
        #
        # @yield [Configuration] Yields the configuration instance to the block.
        def self.configure
          self.configuration ||= Configuration.new
          yield(configuration)
        end

        # Initializes a new instance of Client with the specified options.
        # If options are not provided, defaults to the global configuration
        # or, if none exists, falls back to Configuration defaults.
        #
        # @param options [Hash] Optional settings to configure the client
        # instance.
        # @option options [String] :service_url URL where the PromoStandards
        # API compatible service is hosted.
        # @option options [Logger] :logger Custom logger for this client
        # instance.
        def initialize(options = {})
          config = self.class.configuration || Configuration.new
          @service_url = options[:service_url] || config.service_url
          @logger = options[:logger] || config.logger

          raise ArgumentError, "service_url must be set" if @service_url.nil?
        end
      end
    end
  end
end
