class Topic < ActiveRecord::Base
  
  validates_presence_of :body

  validates_length_of :body , :minimum => 1

  has_one :post, :as => :content, :dependent => :destroy, :validate => true

  accepts_nested_attributes_for :post, :allow_destroy => true

  def text
    self.announcement.to_s + "\n<cut>Read all</cut>\n" + self.body.to_s
  end

  def text=(value)
    delimeter = value[%r{<cut>.*<\/cut>}]
    unless delimeter.nil?
      self.announcement, self.body = value.split(delimeter)
    else
      self.body = value
    end

  end
end