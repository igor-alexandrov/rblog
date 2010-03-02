class Page < ActiveRecord::Base
  acts_as_tree

  def title=(value)
    write_attribute :permalink, (value.transliterate_as_link)
    write_attribute :title, (value)
  end
end
