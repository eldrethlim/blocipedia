Blocipedia::Application.routes.draw do
  
  root to: 'welcome#index'

  get 'about' => 'welcome#about'

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