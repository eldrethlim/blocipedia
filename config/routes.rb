Blocipedia::Application.routes.draw do
  
  root to: 'welcome#index'
  get 'about' => 'welcome#about'
  get '/subscriptions/edit_payment_details' => 'subscriptions#edit_payment_details'
  post '/subscriptions/update_payment_details' => 'subscriptions#update_payment_details'

  devise_for :users

  resources :users
  resources :subscriptions
  resources :plans
  resources :wikis do
    resources :pages do
      resources :subpages
    end
  end

end