class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 30.minutes
  end

end
