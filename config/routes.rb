Tshtask::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, except: [:index]
  resources :money, only: [:index, :show] do
    post :refresh_rates, on: :collection
    get :report, on: :member
  end
end