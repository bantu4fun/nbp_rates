Tshtask::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, except: [:index]
  resources :money, except: [:delete, :edit, :update, :create, :new]
end