require File.dirname(__FILE__) + '/../test_helper'

class CategoryTest < ActiveSupport::TestCase
  fixtures :all
  
  def setup
    @category = Category.new
  end
  
  test "category should should have 0 posts after initializing" do
    assert_equal 0, @category.posts_count, "Category should have 0 posts after initializing"
  end
  
end