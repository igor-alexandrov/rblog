ActionController::Routing::Routes.draw do |map|

  map.login 'login', :controller => 'user_sessions', :action => 'new', :conditions => { :method => :get }
  map.user_session "login", :controller => "user_sessions", :action => "create", :conditions => { :method => :post }
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.namespace:posts, :path_prefix => "" do |post|
    for type in configatron.posts.types.active
      post.resources type
    end
#    post.resources :topics
#    post.resources :links
  end

  map.resources :categories, :as => "c"
  map.resources :posts, :as => "p", :has_many => :comments

  map.post_short "/:id" , :controller => "posts", :action => "show_by_id", :method => "GET", :requirements => { :id => /[0-9]+/ }

  map.increase_post_rating "/p/:id/rating/increase", :controller => "posts", :action => "increase_rating", :method => "POST"
  map.decrease_post_rating "/p/:id/rating/decrease", :controller => "posts", :action => "decrease_rating", :method => "POST"

  map.posts_tag "/t/:name", :controller => "tags", :action => "show"


  map.resources :users, :as => "u"

  map.profile "/profile", :controller => "users", :action => "profile"

  map.root :controller => "home"

  map.namespace :admin do |admin|
    admin.root :controller => 'home', :action => 'index'
#    admin.resource :user_session

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
