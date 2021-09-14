Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health' => 'health#health'
  post '/users' => 'users#create'
  get '/users' => 'users#index'
  post '/login' => 'auth#create'
end
