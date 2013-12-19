module Dinar

  module Generators

    class Install < Rails::Generators::Base

      desc 'start i18n management with dinar'
      argument :source_locale, type: :string, required: true
      argument :target_locales, type: :array, required: true

      def generate
        config = { 'source_locale' => source_locale, 'target_locales' => target_locales }
        create_file 'config/dinar.yml', config.to_yaml
        empty_directory "config/locales/#{source_locale}"
        target_locales.each do |locale|
          empty_directory "config/locales/#{locale}"
        end
      end

    end

  end

end