# frozen_string_literal: true

# PromoStandardsRubyClient is an unofficial Ruby client for interacting with
# PromoStandards API services, providing a flexible configuration interface
# for accessing services such as Product Data, Media Content, and Pricing.
#
# This gem allows users to set up a client with options for service URL and
# logging, making it easy to integrate PromoStandards functionality into
# Ruby applications.
module PromoStandardsRubyClient
  require_relative "promostandards_ruby_client/version"
  require_relative "promostandards_ruby_client/client"
  require_relative "promostandards_ruby_client/configuration"
end
