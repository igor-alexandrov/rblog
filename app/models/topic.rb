class Topic < ActiveRecord::Base
  validates_presence_of :body

  has_one :post, :as => :content, :dependent => :destroy

  def text
    self.announcement.to_s + "\n\n<cut>Read all</cut>\n\n" + self.body.to_s
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