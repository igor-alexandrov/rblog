class Link < ActiveRecord::Base
  validates_presence_of :url
  validates_presence_of :text

  validates_presence_of :description
  validates_length_of :description, :maximum => configatron.posts.link.description.maximum_length

  has_one :post, :as => :content, :dependent => :destroy, :validate => true

  accepts_nested_attributes_for :post, :allow_destroy => true
end
