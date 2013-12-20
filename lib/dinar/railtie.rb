module Dinar
  class Railtie < Rails::Railtie
    generators do
      load 'generators/dinar/install.rb'
    end
    rake_tasks do
      load 'tasks/dinar/update.rake'
      load 'tasks/dinar/translate.rake'
    end
  end
end
