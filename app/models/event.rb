class Event < ActiveRecord::Base
  validates_presence_of :description
  validates_length_of :description, :maximum => configatron.posts.event.description.maximum_length
  
  validates_presence_of :start_moment
  validates_presence_of :stop_moment

  has_one :post, :as => :content, :dependent => :destroy, :validate => true

  accepts_nested_attributes_for :post, :allow_destroy => true
end
