# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem 'authlogic'
  config.gem 'cancan'
  config.gem 'searchlogic', :version => "2.4.12"
  config.gem 'configatron'
  config.gem 'rainbow'
  config.gem 'gravtastic'
  config.gem 'sanitize'
  config.gem 'will_paginate'
  config.gem 'octopi'
  config.gem 'git'
  
  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{RAILS_ROOT}/app/sweepers )
  config.load_paths += %W( #{RAILS_ROOT}/app/presenters )

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  config.plugins = [ :configatron, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  
  unless RAILS_ENV == 'test'
    begin
      email_settings = YAML::load(File.open("#{RAILS_ROOT}/config/email.yml"))
      config.action_mailer.smtp_settings = email_settings[RAILS_ENV] unless email_settings[RAILS_ENV].nil?
    rescue
    end
  end
  
end
