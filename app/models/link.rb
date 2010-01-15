class Link < ActiveRecord::Base
  validates_presence_of :url
  validates_presence_of :description

  has_one :post, :as => :content, :dependent => :destroy
end
