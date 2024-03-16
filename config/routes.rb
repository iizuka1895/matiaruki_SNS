Rails.application.routes.draw do


  # 顧客用
    devise_for :users, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }

# 管理者用
    devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
    }

# public
  namespace :public do

    resources :users, only: [:index, :show, :edit, :update] do
      collection do
        get 'search'
      end
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
      member do
        get 'check'
        patch 'withdrawl'
        get 'liked_posts'
        get 'index_follow'
      end

      resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
       collection do
         get 'search'
       end
       resource :reports, only: [:new, :create]
       get :complete, on: :member
       resource :favorites, only: [:create, :destroy]
       resources :post_comments, only: [:create, :destroy]
       end
      end
    end

# admin
   namespace :admin do
     resources :reports, only: [:index, :show]
     resources :users, only: [:index, :show, :edit, :update]
     resources :posts, only: [:index, :show]
   end


root 'public/homes#top'
get 'about' => 'public/homes#about', as: "about"
end
