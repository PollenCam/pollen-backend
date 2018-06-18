Rails.application.routes.draw do
  devise_for :users

  namespace 'api' do
    namespace 'rest' do
      resources :user_accounts, only: [:create]
    end
  end
end
