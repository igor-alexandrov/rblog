require 'r_blog/customization'
include RBlog::Customization

unless configatron.general.identity.nil?
  IdentityManager.validate(configatron.general.identity)
  ActiveIdentity.identity_name= configatron.general.identity
end

