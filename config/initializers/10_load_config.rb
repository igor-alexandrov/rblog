configatron.configure_from_yaml("#{RAILS_ROOT}/config/settings.yml", :hash => Rails.env )

ActionMailer::Base.default_url_options = { :host => configatron.general.domain_name }
