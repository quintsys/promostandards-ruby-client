# frozen_string_literal: true

RSpec.describe PromostandardsRubyClient::Client do
  after { described_class.configuration = nil }

  it "has a version number" do
    expect(PromostandardsRubyClient::VERSION).not_to be_nil
  end

  describe ".configure" do
    %i[product_data_service_url
       media_content_service_url
       pricing_service_url
       id
       password
       currency
       localization_country
       localization_language
       logger].each_with_index do |setting, index|
      it "allows setting a #{setting}" do
        described_class.configure { |c| c.send(:"#{setting}=", index) }
        expect(described_class.configuration.send(setting)).to eq(index)
      end
    end
  end

  describe "#initialize" do
    let(:id) { "test_id" }
    let(:password) { "test_password" }

    context "with global configuration that includes credentials" do
      it "does not raise an error" do
        described_class.configure do |config|
          config.id = id
          config.password = password
        end
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
