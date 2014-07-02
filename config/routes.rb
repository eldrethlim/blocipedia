Blocipedia::Application.routes.draw do

  devise_for :users
  resources :users

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
