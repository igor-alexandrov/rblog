class Page < ActiveRecord::Base
  acts_as_tree

  def content
    if attribute_present? :content
      Sanitize.clean(read_attribute(:content), Sanitize::Config::RBLOG_BASIC)
    end
  end

  def title=(value)
    write_attribute :permalink, (value.transliterate_as_link)
    write_attribute :title, (value)
  end
  
end
