VersioningDemo::Application.routes.draw do
  resources :policies
  resources :claimants
  resources :claims
  resources :claim_submissions

  root to: 'static_pages#index'
end
