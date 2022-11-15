module TinkoffClient
  module Generators
    class TinkoffClientGenerator < Rails::Generators::Base
      namespace "tinkoff_client"
      source_root File.expand_path("templates", __dir__)

      def copy_initializer_file
        template "tinkoff_client_template.rb", "config/initializers/tinkoff_client.rb"
      end
    end
  end
end
