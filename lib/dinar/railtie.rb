module Dinar
  class Railtie < Rails::Railtie
    generators do
      load 'generators/dinar/install.rb'
    end
    rake_tasks do
      load 'tasks/dinar/update.rake'
    end
  end
end
