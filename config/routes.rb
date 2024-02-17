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
     resources :users, only: [:index, :show, :edit, :update]
     resources :posts, only: [:index, :show, :new, :create]
   end

root 'public/homes#top'
get 'about' => 'public/homes#about', as: "about"
end
