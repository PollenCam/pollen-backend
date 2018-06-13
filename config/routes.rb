Rails.application.routes.draw do
  devise_for :users
  namespace 'api' do
    namespace 'v1' do
      resources :user_accounts, only: [:create]
    end
  end
end
