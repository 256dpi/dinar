namespace :dinar do

  desc 'translate from the source to target locales'
  task :translate do
    config = Dinar::Configuration.new
    config.target_locales.each do |locale|
      Dinar::Translation.new(config.source_locale, locale).run
    end
  end

end
