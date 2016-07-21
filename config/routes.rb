Rails.application.routes.draw do

  resources :migrations, only: [:index, :new, :create] do
    resources :url_discovery, only: [:index]
    resources :url_input, only: [:index, :create]
    resources :url_match, only: [:index]
  end

  root 'migrations#index'
end
