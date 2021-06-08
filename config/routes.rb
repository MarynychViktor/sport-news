Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope'(:locale)',
       constraints: ->(r){ !r.params[:locale] || I18n.available_locales.include?(r.params[:locale].to_sym)} do

    root 'home#index'

    devise_for :users, skip: :omniauth_callbacks, controllers: {
      passwords: 'users/passwords'
    }

    resources :articles do
      resources :comments, except: %i[new edit] do
        member do
          post 'like', to: 'comments#like'
          post 'dislike', to: 'comments#dislike'
        end
      end
    end

    resource :search, only: %i[show]
  end

  namespace :cms do
    root 'home#index'
    post '/', to: 'home#create'
    post '/add_article/:index', to: 'home#add_new_article'

    resources :places, only: %i[index]

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

      resources :articles do
        collection do
          get 'page', to: 'articles#page'
        end

        member do
          post 'publish', to: 'articles#publish'
          post 'unpublish', to: 'articles#unpublish'
        end

      end
    end

    scope module: :articles do
      resources :articles do
        resources :translations, only: %i[edit update]
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
    get 'teams', to: 'teams#all'

    resource :"information_architecture", controller: 'info_architecture', only: %i[show]
    resources :users, except: %i[show new create edit update] do
      collection do
        get 'stats', to: 'users#stats'
      end

      member do
        post 'block', to: 'users#block'
        post 'activate', to: 'users#activate'
        post 'add-admin', to: 'users#add_admin'
        post 'remove-admin', to: 'users#remove_admin'
      end
    end

    resources :languages
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
