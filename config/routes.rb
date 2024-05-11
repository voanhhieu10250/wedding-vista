Rails.application.routes.draw do
  resources :categories
  resources :services

  devise_for :users, path: "/", path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  devise_for :vendors,
             path: :vendor,
             path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }

  namespace :vendors, as: :vendor, path: :vendor do
    resources :services
    root "pages#index"
  end

  namespace :admin do
    root "pages#index"
  end

  # Defines the root path route ("/")
  root "pages#index"
end
