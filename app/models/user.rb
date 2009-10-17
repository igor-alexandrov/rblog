class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes
  end

end
