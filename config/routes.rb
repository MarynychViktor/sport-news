Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    root 'home#index'
  end

  resources :categories, only: %i[index create update destroy] do
    get 'subcategories', to: 'categories#subcategories'
    post 'subcategories/add', to: 'categories#create_subcategory'

    resources :teams, only: %i[index create update destroy]
  end

  namespace :cms do
    resource :"information_architecture", controller: 'info_architecture', only: %i[show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
