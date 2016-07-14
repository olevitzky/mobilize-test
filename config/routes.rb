Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  
  namespace :api do
    resources :users do
      collection do
        post "upload_contacts"
        post "invite_all"
      end
    end
  end
end
