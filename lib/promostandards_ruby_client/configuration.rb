# frozen_string_literal: true

require "logger"

module PromostandardsRubyClient
  # The Configuration class provides a way to set up and manage configuration
  # options for the PromostandardsRubyClient gem, allowing for flexible defaults
  # for various PromoStandards services.
  #
  # == Usage
  #
  # Configuration can be set globally for the application, typically in a
  # Rails initializer:
  #
  #   # config/initializers/promostandards_ruby_client.rb
  #   PromostandardsRubyClient::Client.configure do |config|
  #     # Authentication parameters, always required
  #     config.id = Rails.application.credentials.dig(:vendor, :account_id)
  #     config.password = Rails.application.credentials.dig(:vendor, :password)
  #
  #     # service URLs, required to interact with the service
  #     config.pricing_service_url = 'https://pricing-service-url.com'
  #
  #     # Optional parameters
  #     config.currency = 'USD'
  #     config.localization_country = 'US'
  #     config.localization_language = 'EN'
  #     config.logger = Rails.logger
  #   end
  #
  # Alternatively, configuration options can be passed directly when creating
  # an instance of the client.
  #
  # == Attributes
  #
  # * +pricing_service_url+ - The base URL for the Product Pricing and
  #   Configuration service.
  # * +product_data_service_url+ - The base URL for the Product Data service.
  # * +media_content_service_url+ - The base URL for the Media Content service.
  # * +id+ - The customer ID for authentication with PromoStandards services.
  # * +password+ - Optional password for additional authentication if required
  #   by the service.
  # * +currency+ - The default currency for pricing requests. Defaults to "USD".
  # * +localization_country+ - ISO country code for localization (e.g., "US").
  #   Defaults to "US".
  # * +localization_language+ - ISO language code for localization.
  #   Defaults to "EN".
  # * +logger+ - A logger compatible with Rails.logger (responds to +info+,
  #   +warn+, +error+, etc.).
  #   Defaults to a Rails.logger if defined or a standard Logger instance
  #   outputting to STDOUT.
  #
  class Configuration
    attr_accessor :product_data_service_url, :media_content_service_url,
                  :pricing_service_url, :id, :password, :currency,
                  :localization_country, :localization_language, :logger

    def initialize
      @currency = "USD"
      @localization_country = "US"
      @localization_language = "EN"
      @logger = if defined?(Rails) && Rails.logger
                  Rails.logger
                else
                  Logger.new($stdout)
                end
    end
  end
end
