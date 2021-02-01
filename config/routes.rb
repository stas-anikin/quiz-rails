Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/", { to: "ideas#index", as: :root })

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :ideas do
    get :liked, on: :collection
    resources :likes, only: [:create, :destroy]
    resources :reviews, shallow: true, only: [:create, :destroy] do
    end
  end
end
