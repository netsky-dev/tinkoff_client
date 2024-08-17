# frozen_string_literal: true

require_relative "lib/tinkoff_client/version"

Gem::Specification.new do |spec|
  spec.name = "tinkoff_client"
  spec.version = TinkoffClient::VERSION
  spec.authors = ["netsky_prod"]
  spec.email = ["arenda244@ya.ru"]

  spec.summary = "Tinkoff Ruby API wrapper for payments and e2c payouts."
  spec.description = "Tinkoff Ruby API wrapper for payments and e2c payouts."
  spec.homepage = "https://rubygems.org/gems/tinkoff_client/"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  # spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/netsky-dev/tinkoff_client"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/tinkoff_client"]
  spec.files = ["lib/tinkoff_client.rb",
                "lib/tinkoff_client/version.rb",
                "lib/tinkoff_client/configuration.rb",
                "lib/tinkoff_client/send_request.rb",
                "lib/tinkoff_client/payment/encrypt_card_data.rb",
                "lib/tinkoff_client/payment/request.rb",
                "lib/tinkoff_client/payment/payment.rb",
                "lib/tinkoff_client/payout/request.rb",
                "lib/tinkoff_client/payout/payout.rb",
                "lib/tinkoff_client/payout/encrypt_data.rb",
                "lib/tinkoff_client/generators/tinkoff_client_generator.rb",
                "lib/tinkoff_client/generators/templates/tinkoff_client_template.rb"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "openssl", "~> 3.0.1"
  spec.add_dependency "base64", "~> 0.1.1"
  spec.add_dependency "rest-client", "~> 2.1.0"
  spec.add_dependency "rake", "~> 13.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
