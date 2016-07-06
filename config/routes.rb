Rails.application.routes.draw do

  resources :migrations, only: [:index, :new, :create] do
    resources :resources, only: [:index, :create]
  end

  root 'migrations#index'
end
