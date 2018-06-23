Rails.application.routes.draw do

  root      to: 'static_pages#home'

  devise_for  :users, controllers: {
              registrations:  'registrations',
              sessions:       'sessions'}

  resources :users, only: [:show]

  resources :post_images, only: [:show]
  get       'post_images/:id', to: 'post_images#show', as: 'form_post_images'
  get       'post_images/:id', to: 'post_images#show', as: 'form_post_image'

  get       'recipes/search', to: 'recipes#search', as: 'search_recipes'
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  post      'likes/:recipe_id/create',  to: 'likes#create'
  delete    'likes/:recipe_id/destroy', to: 'likes#destroy'

  post      'made_comments/:recipe_id/create',  to: 'made_comments#create'
  delete    'made_comments/:recipe_id/destroy', to: 'made_comments#destroy'
  post      'made_comment_replies/:made_comment_id/create',  to: 'made_comment_replies#create'
  delete    'made_comment_replies/:made_comment_id/destroy', to: 'made_comment_replies#destroy'


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
end
