Blocipedia::Application.routes.draw do
  devise_for :users
  resources :users
  resources :subscriptions
  resources :plans
  resources :wikis do
    resources :pages do
      resources :subpages
    end
  end

  # Cancel Subscription
  post '/cancel_subscription' => 'subscriptions#cancel_subscription'

  # Payment Details
  post '/update_payment_details' => 'subscriptions#update_payment_details'

  # Subscription Details
  post '/update_subscription_plan' => 'subscriptions#update_subscription_plan'

  #Home and About Pages
  root to: 'welcome#index'
  get 'about' => 'welcome#about'

end