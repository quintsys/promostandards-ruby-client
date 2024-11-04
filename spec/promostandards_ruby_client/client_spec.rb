# frozen_string_literal: true

RSpec.describe PromostandardsRubyClient::Client do
  let(:custom_logger) { Logger.new("/dev/null") }
  let(:custom_service_url) { "https://custom-service-url.com" }

  after do
    described_class.configuration = nil
  end

  it "has a version number" do
    expect(PromostandardsRubyClient::VERSION).not_to be_nil
  end

  describe ".configure" do
    before do
      described_class.configure do |config|
        config.pricing_service_url = custom_service_url
        config.logger = custom_logger
      end
    end

    it "allows setting a global pricing_service_url" do
      expect(described_class.configuration.pricing_service_url)
        .to(eq(custom_service_url))
    end

    it "allows setting a global logger" do
      expect(described_class.configuration.logger).to eq(custom_logger)
    end
  end

  describe "#initialize" do
    let(:id) { "test_id" }
    let(:password) { "test_password" }

    context "with global configuration that includes credentials" do
      before do
        described_class.configure do |config|
          config.id = id
          config.password = password
        end
      end

      it "does not raise an error" do
        expect { described_class.new }.not_to raise_error
      end
    end

    context "without global configuration" do
      it "raises an error if required credentials are missing" do
        expect { described_class.new }
          .to(raise_error(
                ArgumentError,
                "Customer ID (:id) and Password (:password) are required"
              ))
      end

      it "does not raise an error if required credentials are provided" do
        expect { described_class.new(id: id, password: password) }
          .not_to(raise_error)
      end
    end
  end
end
