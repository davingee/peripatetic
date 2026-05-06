require 'rails/generators'

module Peripatetic
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
      
      desc 'Generate Peripatetic migrations and configuration files'

      def copy_migrations
        copy_file 'migration_create_peripatetic_locations.rb',
                  'db/migrate/' + Time.now.strftime('%Y%m%d%H%M%S') + '_create_peripatetic_locations.rb'
        copy_file 'migration_create_peripatetic_countries.rb',
                  'db/migrate/' + (Time.now + 1.second).strftime('%Y%m%d%H%M%S') + '_create_peripatetic_countries.rb'
        copy_file 'migration_create_peripatetic_postal_codes.rb',
                  'db/migrate/' + (Time.now + 2.second).strftime('%Y%m%d%H%M%S') + '_create_peripatetic_postal_codes.rb'
      end

      def copy_initializer
        copy_file 'peripatetic.rb', 'config/initializers/peripatetic.rb'
      end

      def display_instructions
        say \"\\nPeripatetic installed successfully!\\n\\n\"
        say \"Next steps:\\n\", :green
        say \"1. Run: rails db:migrate\\n\"
        say \"2. Check config/initializers/peripatetic.rb for geocoding configuration\\n\"
        say \"3. Add 'include Peripatetic' to your models\\n\"
      end
    end
  end
end
