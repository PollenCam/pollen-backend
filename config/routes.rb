Rails.application.routes.draw do
  devise_for :users

  namespace 'api' do
    namespace 'rest' do
      resources :user_accounts, only: [:create] do
        collection do
          post 'sign_in', 'user_accounts': :sign_in
        end
      end

      resources :events, only: [:index, :create] do
        resources :images, only: [:create]
      end

      resources :memberships, only: [:create]
    end
  end
end
