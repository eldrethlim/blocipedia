Blocipedia::Application.routes.draw do

  get 'categories/index'

  get 'plans/index'

  get 'subscription/options'

  root to: 'welcome#index'

  get 'wikis/new'

  get 'wikis/view'

  get 'wikis/edit'

  get 'wikis/index'

  get 'about' => 'welcome#about'

  devise_for :users

  resources :users
  resources :wikis
  resources :subscriptions
  resources :plans

end