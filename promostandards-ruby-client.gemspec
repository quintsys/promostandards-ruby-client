# frozen_string_literal: true

require_relative "lib/promostandards/ruby/client/version"

Gem::Specification.new do |spec|
  spec.name = "promostandards-ruby-client"
  spec.version = Promostandards::Ruby::Client::VERSION
  spec.authors = ["Erich N Quintero"]
  spec.email = ["qbantek@gmail.com"]

  spec.summary = "Ruby client for accessing PromoStandards API services."
  spec.description = "A Ruby gem for interacting with PromoStandards API " \
                     "services, making it easier for developers to integrate " \
                     "PromoStandards data into their Ruby applications."
  spec.homepage = "https://github.com/quintsys/promostandards-ruby-client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/quintsys/" \
                                     "promostandards-ruby-client"
  spec.metadata["changelog_uri"] = "https://github.com/quintsys/" \
                                   "promostandards-ruby-client/blob/master/" \
                                   "CHANGELOG.md"

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

  spec.metadata["rubygems_mfa_required"] = "true"
end
