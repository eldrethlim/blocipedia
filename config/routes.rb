Blocipedia::Application.routes.draw do

  get 'charges/new'

  devise_for :users
  resources :users

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

  Blocipedia::Application.routes.draw do
  get 'charges/new'

    resources :charges, only: [:new, :create]
  end
end