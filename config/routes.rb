Rails.application.routes.draw do
  resource :contributions

  get '/reply' => 'contributions#reply'
  get '/discuss' => 'contributions#discuss'
  get '/newest' => 'contributions#newest'
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/vote' => 'votes#create'
  get '/logout' => 'sessions#destroy'
  get '/submit' => 'contributions#new'
  get '/user' => 'users#show'
  post '/contributions' => 'contributions#create'
  get '/ask' => 'contributions#ask'
  get '/threads' => 'contributions#threads'
  patch '/user' => 'users#update'

  get 'api/users/:id' => 'users#api_show'
  patch 'api/users' => 'users#api_update'
  get 'api/users/:id/threads' => 'users#api_threads'
  
  get '/api/posts/url' => 'contributions#api_url'
  get '/api/posts/ask' => 'contributions#api_ask'
  get '/api/posts/:id' => 'contributions#api_post'
  get '/api/comments/:id' => 'contributions#api_comment'

  post '/api/votes' => 'votes#create_api'
  get '/api/votes/:id' => 'votes#show_api'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  root 'contributions#newest'
  
end
 

