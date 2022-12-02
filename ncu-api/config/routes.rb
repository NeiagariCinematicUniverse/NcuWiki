Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'api/list', to: 'main_pages#list'
  get 'api/page/:id', to: 'main_pages#page'
  get 'api/side/:id', to: 'side_panel#side'
end
