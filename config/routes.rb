Blocipedia::Application.routes.draw do
  
  root to: 'welcome#index'
  get 'about' => 'welcome#about'
  post '/subscriptions/update_payment_details' => 'subscriptions#update_payment_details'
  post '/wikis/edit' => 'collaborations#add_collaborators'

  devise_for :users

  resources :users
  resources :subscriptions
  resources :plans
  resources :wikis do
    resources :pages do
      resources :subpages
    end
  end

  # Payment Details
  post '/update_payment_details' => 'subscriptions#update_payment_details'

  # Subscription Details
  post '/update_subscription_plan' => 'subscriptions#update_subscription_plan'

  #Home and About Pages
  root to: 'welcome#index'
  get 'about' => 'welcome#about'


end