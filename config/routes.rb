ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.about '/about', :controller => 'site', :action => 'about'
  map.feedback '/feedback', :controller => 'site', :action => 'feedback'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  
  map.resources :ideas
  map.resources :categories
  map.resources :users
  map.resource :session

  map.root :controller => 'ideas', :action => 'index'
  map.connect 'u/:login.:format', :controller => 'users', :action => 'ideas' # u/rob.xml

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end