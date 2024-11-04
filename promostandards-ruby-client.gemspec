# frozen_string_literal: true

require_relative "lib/promostandards/ruby/client/version"

Gem::Specification.new do |spec|
  spec.name = "promostandards-ruby-client"
  spec.version = Promostandards::Ruby::Client::VERSION
  spec.authors = ["quintsys"]
  spec.email = ["contact@quintsys.com"]

  spec.summary = "Ruby client for accessing PromoStandards API services."
  spec.description = <<~HERE
    A Ruby gem for interacting with PromoStandards API services, making it
    easier for developers to integrate PromoStandards data into their
    Ruby applications.
  HERE
  spec.homepage = "https://github.com/quintsys/promostandards-ruby-client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "homepage_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }

  gemspec = File.basename(__FILE__)
  spec.files =
    IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
      ls.readlines("\x0", chomp: true).reject do |f|
        (f == gemspec) ||
          f.start_with?(*%w[bin/ test/ spec/ features/ .git .github Gemfile])
      end
    end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
