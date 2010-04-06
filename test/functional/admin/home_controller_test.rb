require File.dirname(__FILE__) + '/../../test_helper'

class Admin::HomeControllerTest < ActionController::TestCase
  def setup
    
  end
  
  def test_disallow_unauthenticated_access
    get :index
    assert_login_promt
  end
  
  
end