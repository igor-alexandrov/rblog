ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => 'user_sessions', :action => 'new', :conditions => { :method => :get }
  map.user_session "login", :controller => "user_sessions", :action => "create", :conditions => { :method => :post }
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.namespace:posts, :path_prefix => "" do |post|
    for type in configatron.posts.types.active
      post.resources type
    end
  end

  map.resources :categories, :as => "c"
  map.resources :posts, :as => "p", :has_many => :comments do |posts|
    if configatron.posts.rating.use
      posts.increase_rating   "rating/increase", :controller => "posts", :action => "increase_rating", :method => "POST"
      posts.decrease_rating   "rating/decrease", :controller => "posts", :action => "decrease_rating", :method => "POST"
      posts.toggle_favourite  "toogle_favourite", :controller => "posts", :action => "toggle_favourite", :method => "POST"      
    end
  end

  map.post_short "/:id", :controller => "posts", :action => "show_by_id", :method => "GET", :requirements => { :id => /[0-9]+/ }

  map.posts_tag "/t/:name", :controller => "tags", :action => "show"

  map.resources :users, :as => "u"

  map.namespace :my do |my|
    my.root :controller => 'home', :action => 'index'
      
    my.new_activation '/activate/:activation_code', :controller => 'activations', :action => 'new', :method => "GET"
    my.activation '/activate/', :method => "POST", :controller => 'activations', :action => 'create'  
        
    my.resource :profile, :controller => "profile", :only => [:show, :edit, :update] do |profile|
      
    end
    my.resources :favourites
  end

  map.root :controller => "home"

  map.namespace :admin do |admin|
    admin.root :controller => 'home', :action => 'index'

    admin.resources :users, :collection => {:update_individual => :put}

    admin.resources :posts
    admin.change_status 'posts/change_status', :controller => "posts", :action => "change_status"
    admin.resources :pages
    admin.preferences 'preferences', :controller => "blog_parameters", :action => "index"

    #admin.register 'admin/register', :controller => 'users', :action => 'create'
    #admin.signup 'admin/signup', :controller => 'users', :action => 'new'
  end

  map.page 'pages/*href', :controller => "pages", :action => "show"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
