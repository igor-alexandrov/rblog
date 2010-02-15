require 'r_blog/customization'
include RBlog::Customization

unless configatron.general.identity.nil?
  IdentityManager.validate(configatron.general.identity)
  ActiveIdentity.identity_name= configatron.general.identity
end

module ActionController
  class Base
    self.prepend_view_path("#{RAILS_ROOT}/app/identities/#{configatron.general.identity}/views")
  end
end