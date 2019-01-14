Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        post 'user_token' => 'user_token#create'
        resources :recipe_ingredients
        resources :ingredients
        resources :recipes
        resources :users
    end
  end
end