Rails.application.routes.draw do
  namespace :api do
    resources :events
  end

  get '/:id', to: 'users#show', as: 'user'
  root to: 'users#index'
end
