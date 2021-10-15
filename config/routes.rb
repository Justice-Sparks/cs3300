Rails.application.routes.draw do
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Adding route for projects index....I think?
  Rails.application.routes.draw do
    root "projects#index"
    resources :projects
  end

end
