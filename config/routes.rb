ActionController::Routing::Routes.draw do |map|

  #map.resources :posts do |post|
  #  post.resources :comments, :member => {:comment => :get, :post => :post}
  #  post.new_comment '/comments/new/:comment_id', :controller => 'comments', :action => 'new'
  #end

  map.namespace:posts, :path_prefix => "p" do |post|
    post.resources :topics
  end

  map.resources :categories, :as => "c"
  map.resources :posts, :as => "p", :has_many => :comments

  map.increase_post_rating "/p/:id/rating/increase", :controller => "posts", :action => "increase_rating", :method => "POST"
  map.decrease_post_rating "/p/:id/rating/decrease", :controller => "posts", :action => "decrease_rating", :method => "POST"

  map.posts_tag "/t/:name", :controller => "tags", :action => "show"

  map.resources :users, :as => "u"
  map.profile "/profile", :controller => "users", :action => "profile"

  map.root :controller => "home"

  map.namespace :admin do |admin|
    admin.root :controller => 'home', :action => 'index'
    admin.resource :user_session
    admin.login 'login', :controller => 'user_sessions', :action => 'new'
    admin.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
    admin.resources :users

    admin.resources :posts
    admin.change_status 'posts/change_status', :controller => "posts", :action => "change_status"
    admin.resources :pages
    admin.preferences 'preferences', :controller => "blog_parameters", :action => "index"

    #admin.register 'admin/register', :controller => 'users', :action => 'create'
    #admin.signup 'admin/signup', :controller => 'users', :action => 'new'
  end

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.


  map.page 'pages/*href', :controller => "pages", :action => "show"


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
