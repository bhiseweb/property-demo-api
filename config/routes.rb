Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :properties do
    collection do 
      get :stats
    end
  end
end
