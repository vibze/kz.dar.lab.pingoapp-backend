Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'sessions/new' => 'sessions#new'

      post 'buddies' => 'buddies#list'
      put 'buddies/:buddy_id/blacklist' => 'buddies#blacklist'
      delete 'buddies/:buddy_id/unblacklist' => 'buddies#unblacklist'

      post 'pings/new' => 'pings#new'
      get 'pings/recent' => 'pings#recent'

      post 'profile/avatar' => 'profile/update'
    end
  end
end
