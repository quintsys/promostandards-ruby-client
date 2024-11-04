# frozen_string_literal: true

require_relative "services/product_pricing_and_configuration"

module PromostandardsRubyClient
  # The Client class is the main entry point for interacting with the
  # PromoStandards API through the gem.
  # This class provides flexible configuration options, allowing users
  # to specify the API service URLs, logger, and other settings either
  # globally or per instance.
  #
  # == Configuration
  #
  # Configuration can be set globally across the application, typically
  # in a Rails initializer:
  #
  #   # config/initializers/promostandards_ruby_client.rb
  #   PromostandardsRubyClient::Client.configure do |config|
  #     config.id = Rails.application.credentials.dig(:vendor, :account_id)
  #     config.password = Rails.application.credentials.dig(:vendor, :password)
  #     config.pricing_service_url = 'https://pricing-service-url.com'
  #   end
  #
  # Alternatively, options can be passed directly to an instance of the
  # Client:
  #
  #   client = PromostandardsRubyClient::Client.new(
  #     id: Rails.application.credentials.dig(:vendor, :account_id)
  #     password: Rails.application.credentials.dig(:vendor, :password),
  #     pricing_service_url: 'https://another-pricing-service-url.com',
  #   )
  #
  # == Example Usage
  #
  #   # Configure the client globally in a Rails initializer
  #   # config/initializers/promostandards_ruby_client.rb
  #
  #   # Instantiate the client
  #   client = PromostandardsRubyClient::Client.new
  #
  class Client
    include Services::ProductPricingAndConfiguration
    # include Services::ProductData
    # include Services::MediaContent
    # include Services::Inventory

    class << self
      attr_accessor :configuration
    end

    # Allows global configuration of the Client class. When called with a
    # block, it yields an instance of Configuration, enabling settings to be
    # set for the entire application.
    #
    # @example Configuring the client globally
    #   PromostandardsRubyClient::Client.configure do |config|
    #     config.id = Rails.application.credentials.dig(:acme, :account_id)
    #     config.password = Rails.application.credentials.dig(:acme, :password)
    #     config.pricing_service_url = 'https://pricing-service-url.com'
    #     config.logger = Rails.logger
    #   end
    #
    # @yield [Configuration] Yields the configuration instance to the block.
    def self.configure
      self.configuration ||= PromostandardsRubyClient::Configuration.new
      yield(configuration)
    end

    # Initializes a new instance of Client with the specified options.
    # If options are not provided, defaults to the global configuration
    # or, if none exists, falls back to Configuration defaults.
    #
    # @param options [Hash] Optional settings to configure the client instance.
    #
    def initialize(options = {})
      config = self.class.configuration || Configuration.new

      set_authentication(options, config)
      set_service_urls(options, config)
      set_localization_and_currency(options, config)

      # Logger
      @logger = options[:logger] || config.logger
    end

    private

    def set_authentication(options, config)
      @id = options[:id] || config.id
      @password = options[:password] || config.password
      return unless @id.to_s.empty? || @password.to_s.empty?

      raise ArgumentError,
            "Customer ID (:id) and Password (:password) are required"
    end

    def set_service_urls(options, config)
      @product_data_service_url = options[:product_data_service_url] ||
                                  config.product_data_service_url
      @media_content_service_url = options[:media_content_service_url] ||
                                   config.media_content_service_url
      @pricing_service_url = options[:pricing_service_url] ||
                             config.pricing_service_url
    end

    def set_localization_and_currency(options, config)
      @currency = options[:currency] || config.currency
      @localization_country = options[:localization_country] ||
                              config.localization_country
      @localization_language = options[:localization_language] ||
                               config.localization_language
    end
  end
end
