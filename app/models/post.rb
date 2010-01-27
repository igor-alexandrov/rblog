class Post < ActiveRecord::Base
  belongs_to :content, :polymorphic => true, :dependent => :destroy

  has_many :comments, :order => "created_at ASC"

  belongs_to :category, :counter_cache => true
  belongs_to :author, :class_name => "User", :counter_cache => true

  acts_as_taggable_on :tags

  validates_presence_of :author

  validates_presence_of :title
  validates_length_of   :title, :minimum => 2

  # TODO Понять, стоит ли делать :include => [:tags] 
  named_scope :published, :include => [:category, :author, :content], :conditions => "published_at IS NOT NULL", :order => "published_at DESC, id DESC"
  named_scope :draft, :conditions => "published_at IS NULL", :order => "updated_at DESC"

  named_scope :topics, :conditions => { :content_type => "Topic" }

  def attributes=(attributes = {})
    self.content_type = attributes[:content_type].to_s
    super
  end

  def build_content(attributes = {})
    self.content = content_type.classify.constantize.new(attributes)
  end

#  def self.new_with_content(content_type, params, author)
#    post = class_eval("self.#{content_type.to_s.downcase.pluralize}.new")
#    post.update_attributes(params[content_type.to_s.downcase.to_sym][:post])
#    params[content_type.to_s.downcase.to_sym].delete(:post)
#
#    content = eval("#{content_type}.new")
#
#    content.update_attributes(params[content_type.to_s.downcase.to_sym])
#    if content.save
#      post.update_attributes({:author => author, :content => content})
#      post
#    else
#      post.update_attributes({:author => author})
#      post.errors.add(content.errors)
#      post
#    end
#  end

  def to_param
    self.permalink
  end

  def first_level_comments
    Comment.find(:all, :conditions => {:post_id => self.id, :parent_comment_id => nil})
  end

  def draft?
    self.published_at.nil?
  end

  def published?
    !self.draft?
  end

  def draft!
    self.published_at = nil
    self.save!
  end

  def publish!
    self.published_at = DateTime.now
    self.save!
  end

  def title=(value)
    write_attribute :permalink, (value.transliterate_as_link)
    write_attribute :title, (value)
  end

  def add_comment(comment_params, author)
    if author.nil?
      comment = GuestComment.new(comment_params)
    else
      comment = UserComment.new(comment_params.merge({:author_id => author.id}))
    end
    comment.post = self
    comment
  end

end
