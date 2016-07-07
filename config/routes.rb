Rails.application.routes.draw do

  resources :migrations, only: [:index, :new, :create] do
    resources :resources, only: [:index, :create]
    resources :url_match, only: [:index]
  end

  root 'migrations#index'
end
