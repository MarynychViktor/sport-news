Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    root 'home#index'
  end


  namespace :cms do
    resources :categories, only: %i[index new create edit update destroy] do
      member do
        post 'hide', to: 'categories#hide'
        post 'appear', to: 'categories#appear'
      end

      resources :subcategories, only: %i[index new create update destroy]
      resources :teams, only: %i[index create update destroy]
    end
    resource :"information_architecture", controller: 'info_architecture', only: %i[show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
