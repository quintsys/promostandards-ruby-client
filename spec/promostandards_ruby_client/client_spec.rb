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
        config.service_url = custom_service_url
        config.logger = custom_logger
      end
    end

    it "allows setting a global service_url" do
      expect(described_class.configuration.service_url)
        .to eq(custom_service_url)
    end

    it "allows setting a global logger" do
      expect(described_class.configuration.logger).to eq(custom_logger)
    end
  end

  describe "#initialize" do
    context "with global configuration" do
      before do
        described_class.configure do |config|
          config.service_url = custom_service_url
          config.logger = custom_logger
        end
      end

      it "uses global configuration for service_url" do
        client = described_class.new
        expect(client.instance_variable_get(:@service_url))
          .to(eq(custom_service_url))
      end

      it "uses global configuration for logger" do
        client = described_class.new
        expect(client.instance_variable_get(:@logger)).to eq(custom_logger)
      end

      it "overrides global configuration with instance options" do
        alternate_service_url = "https://another-service-url.com"
        client = described_class.new(service_url: alternate_service_url)
        expect(client.instance_variable_get(:@service_url))
          .to(eq(alternate_service_url))
      end
    end

    context "without global configuration" do
      it "raises an error if service_url is not provided" do
        expect do
          described_class.new
        end.to raise_error(ArgumentError, "service_url must be set")
      end

      it "uses provided service_url if given" do
        client = described_class.new(service_url: custom_service_url,
                                     logger: custom_logger)
        expect(client.instance_variable_get(:@service_url))
          .to(eq(custom_service_url))
      end

      it "uses provided logger if given" do
        client = described_class.new(service_url: custom_service_url,
                                     logger: custom_logger)
        expect(client.instance_variable_get(:@logger)).to eq(custom_logger)
      end
    end
  end
end
