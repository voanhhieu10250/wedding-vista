Rails.application.routes.draw do
  get "tools/checklist"
  get "tools/budget"
  get "tools/vendors"
  get "tools", to: "tools#index", as: :tools_root


  resources :forums, only: %i[index show] do
    resources :discussions
  end

  resources :discussions, only: %i[index new create] do
    resources :comments, except: %i[index new]
  end

  get "galleries/index"
  get "galleries/show"

  resources :categories, only: %i[show]
  resources :services, only: %i[index show] do
    resources :reviews, only: %i[create]
    resources :galleries, only: %i[index show]
  end

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
      member do
        post :publish
        post :unpublish
      end
      resources :addresses, except: %i[new]
      resources :galleries
      resources :common_questions, as: :questions, path: :questions, except: %i[new]
      resources :boostings, except: %i[show]
    end
    post "services/search", to: "services#search"

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
    get "payment/success", to: "transactions#success_callback", as: :payment_success
    get "payment/cancel", to: "transactions#cancel_callback", as: :payment_cancel
    post "payment/verify-payment", to: "transactions#verify_payment_webhook", as: :payment_verify
    post "payment/:id/cancel", to: "transactions#cancel", as: :payment_manual_cancel

    resources :spendings, only: %i[index show new create]

    root "services#index"
  end

  resources :ideas, only: %i[show], path: "/ideas"

  # Wedding idea topics category details. e.g. /wedding-ideas/1
  resources :topic_categories, only: %i[show], path: "/wedding-ideas" do
    resources :topics, only: %i[show]
  end

  scope "/wedding-ideas" do
    root "ideas#index", as: :wedding_ideas_root
  end

  namespace :admin do
    resources :topic_categories # Wedding idea topics categories
    resources :topics # Wedding idea topics
    resources :ideas
    resources :categories # Services categories
    resources :forums

    root "pages#index"
  end

  # Defines the root path route ("/")
  root "pages#index"
end
