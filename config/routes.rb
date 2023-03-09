Rails.application.routes.draw do
  root 'recipes#welcome'

  resources :recipes, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :categories, only: [:index]
end
