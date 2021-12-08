Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/:shortcode', to: 'link#show', as: 'shortcode'
  post '/link', to: 'link#create'
  root 'pages#index'
end
