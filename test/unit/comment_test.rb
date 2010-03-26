require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :all
  
  def setup
    @comment = Comment.new
  end
  
  test "comment depth should be 0 after initializing" do
    assert_equal 0, @comment.depth, "Comment depth should be 0 after initializing"
  end
  
end