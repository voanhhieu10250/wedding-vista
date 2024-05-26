Rails.application.routes.draw do
  resources :categories
  resources :services, only: %i[index show]

  devise_for :users,
             path: "/",
             path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" },
             controllers: { registrations: "users/registrations" }
  devise_for :vendors,
             path: :vendor,
             path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" },
             controllers: { registrations: "vendors/registrations" }

  #  Have to name the namespace vendors to avoid conflict between the auto mapped views with the devise_for :vendors,
  # which will have a vendor_root_path helper method, and the views will be in the views/vendors folder
  namespace :vendors, as: :vendor, path: :vendor do
    resources :services do
      resources :addresses
      resources :galleries
      resources :common_questions, as: :questions, path: :questions
    end

    resources :topic_categories, only: %i[index show]
    resources :topics, only: %i[index show]
    resources :ideas do
      member do
        post :publish
        post :unpublish
        post :pay
      end
    end

    resources :transactions, only: %i[index show new create]
    get "payment/success", to: "transactions#success", as: :payment_success
    get "payment/cancel", to: "transactions#cancel", as: :payment_cancel

    resources :spendings

    root "services#index"
  end

  scope "/wedding-ideas" do
    resources :topic_categories, only: %i[index show]
    resources :topics, only: %i[index show]
    resources :ideas, only: %i[index show]

    root "ideas#index", as: :wedding_ideas_root
  end

  namespace :admin do
    resources :topic_categories
    resources :topics
    resources :ideas

    root "pages#index"
  end

  # Defines the root path route ("/")
  root "pages#index"
end
