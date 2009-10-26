ActionController::Routing::Routes.draw do |map|

  #map.resources :posts do |post|
  #  post.resources :comments, :member => {:comment => :get, :post => :post}
  #  post.new_comment '/comments/new/:comment_id', :controller => 'comments', :action => 'new'
  #end

  map.resources :posts, :has_many => :comments
  map.posts_tag "/posts/tag/:name", :controller => "tags", :action => "show"


  map.resources :blog_parameters


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  map.namespace :admin do |admin|
    admin.root      :controller => 'home', :action => 'index'
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

  map.connect '*href', :controller => "pages", :action => "show"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
