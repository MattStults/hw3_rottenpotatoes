Rottenpotatoes::Application.routes.draw do
  resources :movies
  match 'director', :controller => 'movies', :action => 'director', :as => :director
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
