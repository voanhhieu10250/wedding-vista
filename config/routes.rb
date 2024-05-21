Rails.application.routes.draw do
  resources :ideas
  resources :topics
  resources :topic_categories
  resources :categories
  resources :services, only: %i[index show]

  devise_for :users,
             path: "/",
             path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" },
             controllers: { registrations: "users/registrations" }
  devise_for :vendors,
             path: :vendor,
             path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }

  #  Have to name the namespace vendors to avoid conflict between the auto mapped views with the devise_for :vendors,
  # which will have a vendor_root_path helper method, and the views will be in the views/vendors folder
  namespace :vendors, as: :vendor, path: :vendor do
    resources :services do
      resources :addresses
      resources :galleries
      resources :common_questions, as: :questions, path: :questions
    end
    root "services#index"
  end

  namespace :admin do
    root "pages#index"
  end

  # Defines the root path route ("/")
  root "pages#index"
end
