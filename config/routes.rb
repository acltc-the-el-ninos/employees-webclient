Rails.application.routes.draw do
  get '/employees' => 'employees#index'
  get '/employees/new' => 'employees#new'
  get '/employees/:id' => 'employees#show'
  post '/employees' => 'employees#create'
end
