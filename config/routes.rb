Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :members do
    resources :friendships, only: %i[create destroy index new]
  end
  root to: 'members#index'
end
