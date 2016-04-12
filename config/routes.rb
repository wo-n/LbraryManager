LibraryManager::Application.routes.draw do
  root to: "top#index"

  resources :books do
    get "search", on: :collection #本の検索
    put "reserve", on: :member    #本の予約
  end

  resources :notices

  resources :reservations, except: [:show, :destroy] do
    get "rtoaEdit", on: :collection
    put "rtoaUpdate", on: :collection
  end

  resource :session, only: [:new, :create, :destroy]

  resources :members

  resources :libraries, only: [:index]

end
