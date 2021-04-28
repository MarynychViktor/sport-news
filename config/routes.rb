Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'users/passwords'
  }

  root 'home#index'

  namespace :admin do
    root 'home#index'
  end


  namespace :cms do
    resources :categories, only: %i[index new create edit update destroy] do
      member do
        post 'hide', to: 'categories#hide'
        post 'appear', to: 'categories#appear'
        post 'position', to: 'categories#change_position'
      end

      resources :subcategories, only: %i[index new create edit update destroy] do
        member do
          post 'hide', to: 'subcategories#hide'
          post 'appear', to: 'subcategories#appear'
          post 'position', to: 'subcategories#change_position'
          get 'select_category', to: 'subcategories#select_category'
          post 'update_category', to: 'subcategories#update_category'
        end
      end
    end

    resources :subcategories, only: [] do
      resources :teams, only: %i[index new edit create update destroy] do
        member do
          post 'hide', to: 'teams#hide'
          post 'appear', to: 'teams#appear'
          post 'position', to: 'teams#change_position'
          get 'select_category', to: 'teams#select_category'
          post 'update_category', to: 'teams#update_category'
        end
      end
    end

    resource :"information_architecture", controller: 'info_architecture', only: %i[show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
