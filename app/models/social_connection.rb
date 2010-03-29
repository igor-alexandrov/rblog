class SocialConnection < ActiveRecord::Base
  belongs_to :user
  belongs_to :pattern, :foreign_key => "pattern_id", :class_name => "SocialConnectionPattern"
end
