require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :all
  
  def setup
    @post = Post.new
  end
  
  test "post should not be valid after initializing" do
    assert_false @post.valid?, "Post should be invalid after initializing"
  end
  
  test "post should be a draft after initializing" do
    assert_true @post.draft?, "Post should be a draft after initializing"
  end
  
  test "post should be published after calling @post.publish!" do
    post = posts(:valid_not_published)
    post.publish!
    assert_false post.draft?
    assert_not_nil post.published_at
  end
  
  test "@post.published_at should not change after a post been republished" do
    post = posts(:valid_not_published)
    post.publish!
    first_time = post.published_at
    sleep(1)
    post.draft!
    post.publish!
    second_time = post.published_at
    assert_equal first_time, second_time
  end
  
  test "post should should have 0 comments after initializing" do
    assert_equal 0, @post.comments_count, "Post should have 0 comments after initializing"
  end
end
