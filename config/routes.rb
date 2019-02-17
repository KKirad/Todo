Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :todo_lists, only: [:index, :create, :update, :destroy] do
        member do
          delete :temporary_destroy
          patch :restore
        end
        resources :todo_items, only: :create
      end
      resources :todo_items, only: [:update, :destroy] do
        member do
          delete :temporary_destroy
          patch :restore
        end
      end
    end
  end
  root 'welcome#index'
  get '*path' => 'welcome#index'
end
