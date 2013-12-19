require 'open-uri'

namespace :dinar do

  desc 'update main rails locales'
  task :update do
    config = Dinar::Configuration.new
    begin
      config.all_locales.each do |locale|
        content = open("https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/#{locale}.yml"){ |f| f.read }
        File.open("config/locales/#{locale}.yml", 'w') { |file| file.write(content) }
        puts "updated '#{locale}'"
      end
    rescue OpenURI::HTTPError
      puts "locale '#{locale}' not found in 'rails-i18n' repository!"
    end
  end

end