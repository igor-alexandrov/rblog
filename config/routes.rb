RBlog::Application.routes.draw do
  match 'login' => 'user_sessions#new', :as => :login, :via => 'get'
  match 'login' => 'user_sessions#create', :as => :user_session, :via => 'post'
  match 'logout' => 'user_sessions#destroy', :as => :logout
  namespace :posts do
  end

  resources :categories
  resources :posts do
  
  
      # match 'rating/increase' => 'posts#increase_rating', :as => :increase_rating, :method => 'POST'
    # match 'rating/decrease' => 'posts#decrease_rating', :as => :decrease_rating, :method => 'POST'
    # match 'toogle_favourite' => 'posts#toggle_favourite', :as => :toggle_favourite, :method => 'POST'
  end

  match '/:id' => 'posts#show_by_id', :as => :post_short, :method => 'GET', :requirements => { :id => /[0-9]+/ }
  match '/t/:name' => 'tags#show', :as => :posts_tag
  resources :users
    match '/' => 'home#index'
  namespace :my do
      match '/activation/:activation_code' => 'activations#new', :as => :new_activation, :method => 'GET'
      match '/activation/' => 'activations#create', :as => :activation, :method => 'POST'
      resource :profile
      resources :favourites
  end

  match '/version' => 'version#index', :as => :version
  match '/' => 'home#index'
    match '/' => 'home#index'
  namespace :admin do
      resources :users do
        collection do
    put :update_individual
    end
    
    
    end
      resources :posts
      match 'posts/change_status' => 'posts#change_status', :as => :change_status
      resources :pages
      match 'preferences' => 'blog_parameters#index', :as => :preferences
  end

  root :to => "home#index"

  match 'pages/*href' => 'pages#show', :as => :page
end
