class Post < ActiveRecord::Base
  belongs_to :content, :polymorphic => true, :dependent => :destroy

  has_many :comments, :order => "created_at ASC"

  has_many :favourites, :foreign_key => :object_id, :dependent => :destroy, :validate => false, :conditions => {:object_type => "Post"}

  belongs_to :category, :counter_cache => true
  belongs_to :author, :class_name => "User", :counter_cache => true

  acts_as_taggable_on :tags

  validates_presence_of :category

  validates_presence_of :author

  validates_presence_of :title
  validates_length_of   :title, :minimum => 2

  named_scope :draft, :conditions => "published_at IS NULL", :order => "updated_at DESC"

  named_scope :topics, :conditions => { :content_type => "Topic" }

  def self.per_page
    10
  end
  
  def self.published(options = {})
    self.paginate :page => options[:page], :conditions => {:draft => false}, :order => "published_at DESC, id DESC"
  end
  
  def self.published_in_category( category, options = {} )
  end
  
  def self.published_with_tag( tag, options = {} )
    tagged_with(tag).paginate(:page => options[:page], :conditions => {:draft => false}, :order => "published_at DESC, id DESC")
  end
  
  def after_initialize 
    return unless new_record?
    self.comments_count = 0
  end

  def attributes=(attributes = {})
    self.content_type = attributes[:content_type].to_s
    super
  end

  def build_content(attributes = {})
    self.content = content_type.classify.constantize.new(attributes)
  end

  def to_param
    self.permalink
  end

  def before_save
    self.published_at = DateTime.now if (!self.draft? && self.published_at.nil?)
    permalink = self.title.transliterate_as_link
    if self.permalink != permalink
      permalink << "-" << ActiveSupport::SecureRandom.hex(4) if Post.find_by_permalink(:first, permalink).nil?
      self.permalink = permalink
    end
  end
  
  def draft?
    self.draft
  end
  
  def published?
    !self.draft?
  end

  def draft!
    self.draft = true
    self.save!
  end

  def publish!
    self.draft = false
    self.published_at = DateTime.now if self.published_at.nil?
    self.save!
  end

  def title=(value)
    write_attribute :title, (value)
  end

  def new_comment(parent_comment_id, author)
    if author.nil?
      comment = GuestComment.new
    else
      comment = UserComment.new(:author_id => author.id)
    end
    comment.post = self
    begin
      parent_comment = Comment.find( parent_comment_id )
    rescue ActiveRecord::RecordNotFound
      parent_comment = nil
    end

    unless parent_comment.nil?
      comment.parent_comment = parent_comment      
    end

    comment
  end

  def create_comment(comment_params, author)
    if author.nil?
      comment = GuestComment.new(comment_params)
    else
      comment = UserComment.new(comment_params.merge({:author_id => author.id}))
    end
    comment.post = self
    comment.depth = comment.parent_comment_depth + 1
    comment
  end

end
