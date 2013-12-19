module Dinar
  class Configuration

    attr_accessor :source_locale, :target_locales

    def initialize
      config = YAML.load(File.read("#{Rails.root}/config/dinar.yml"))
      @source_locale = config['source_locale']
      @target_locales = config['target_locales']
    end

    def all_locales
      [self.source_locale] + self.target_locales
    end

  end
end