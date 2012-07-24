Spreedemo::Application.routes.draw do
  
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, :at => '/'
  
    root :to => 'products#index'

  resources :products

  match '/locale/set', :to => 'locale#set'

  resources :tax_categories

  resources :states, :only => :index

  # non-restful checkout stuff
  match '/checkout/update/:state', :to => 'checkout#update', :as => :update_checkout
  match '/checkout/:state', :to => 'checkout#edit', :as => :checkout_state
  match '/checkout', :to => 'checkout#edit', :state => 'address', :as => :checkout

  resources :orders do
    post :populate, :on => :collection

    resources :line_items
    resources :creditcards
    resources :creditcard_payments

    resources :shipments do
      member do
        get :shipping_method
      end
    end

  end
  get '/cart', :to => 'orders#edit', :as => :cart
  put '/cart', :to => 'orders#update', :as => :update_cart
  put '/cart/empty', :to => 'orders#empty', :as => :empty_cart

  resources :shipments do
    member do
      get :shipping_method
      put :shipping_method
    end
  end

  #   # route globbing for pretty nested taxon and product paths
  match '/t/*id', :to => 'taxons#show', :as => :nested_taxons
  #
  #   #moved old taxons route to after nested_taxons so nested_taxons will be default route
  #   #this route maybe removed in the near future (no longer used by core)
  #   map.resources :taxons
  #

  namespace :admin do
    resources :adjustments
    resources :zones
    resources :users do
      member do
        post :dismiss_banner
      end
    end
    resources :countries do
      resources :states
    end
    resources :states
    resources :tax_categories
    resources :configurations, :only => :index
    resources :products do
      resources :product_properties
      resources :images do
        collection do
          post :update_positions
        end
      end
      member do
        get :clone
      end
      resources :variants do
        collection do
          post :update_positions
        end
      end
      resources :option_types do
        member do
          get :select
          get :remove
        end
        collection do
          get :available
          get :selected
          post :update_positions
        end
      end
      resources :taxons do
        member do
          get :select
          delete :remove
        end
        collection do
          post :available
          post :batch_select
          get  :selected
        end
      end
    end

    resources :option_types do
      collection do
        post :update_positions
      end
    end

    resources :properties do
      collection do
        get :filtered
      end
    end

    resources :prototypes do
      member do
        get :select
      end

      collection do
        get :available
      end
    end

    resource :inventory_settings
    resource :image_settings
    resources :google_analytics

    resources :orders do
      member do
        put :fire
        get :fire
        post :resend
        get :history
      end

      resource :customer, :controller => "orders/customer_details"

      resources :adjustments
      resources :line_items
      resources :shipments do
        member do
          put :fire
        end
      end
      resources :return_authorizations do
        member do
          put :fire
        end
      end
      resources :payments do
        member do
          put :fire
        end
      end
    end

    resource :general_settings do
      collection do
        post :dismiss_alert
      end
    end

    resources :taxonomies do
      member do
        get :get_children
      end

      resources :taxons
    end

    resources :reports, :only => [:index, :show] do
      collection do
        get :sales_total
        post :sales_total
      end
    end

    resources :shipments
    resources :shipping_methods
    resources :shipping_categories
    resources :tax_rates
    resource  :tax_settings
    resources :calculators

    resources :trackers
    resources :payment_methods
    resources :mail_methods do
      member do
        post :testmail
      end
    end
  end

  match '/admin', :to => 'admin/orders#index', :as => :admin

  match '/content/cvv', :to => 'content#cvv'
  match '/content/*path', :to => 'content#show', :via => :get, :as => :content
  
  
  
  
  
  
          # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
