class Topic < ActiveRecord::Base
  validates_presence_of :body

  validates_length_of :body , :minimum => 1

  has_one :post, :as => :content, :dependent => :destroy, :validate => true

  accepts_nested_attributes_for :post, :allow_destroy => true

  # before_save :sanitize_content

  def announcement
    if attribute_present? :announcement
      Sanitize.clean(read_attribute(:announcement), Sanitize::Config::RBLOG_BASIC)
    end
  end

  def body
    if attribute_present? :body
      Sanitize.clean(read_attribute(:body), Sanitize::Config::RBLOG_BASIC)
    end
  end

  def text
    text = ""
    unless read_attribute(:announcement).blank?
      text = read_attribute(:announcement) + "\n<cut>Read all</cut>\n"
    end
    text = text + read_attribute(:body).to_s
  end

  def text=(value)
    delimeter = value[%r{<cut>.*<\/cut>}]
    unless delimeter.nil?
      self.announcement, self.body = value.split(delimeter)
    else
      self.body = value
    end

  end
  
  private
  def sanitize_content
    self.announcement = Sanitize.clean(announcement, Sanitize::Config::RBLOG_BASIC) if attribute_present? :announcement
    self.body = Sanitize.clean(body, Sanitize::Config::RBLOG_BASIC) if attribute_present? :body
  end
end