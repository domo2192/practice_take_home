Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :customers do
        post '/:id/subscriptions', to: 'customer_subscriptions#create'
        patch '/:id/subscriptions/:id', to: 'customer_subscriptions#update'
        get '/:id/subscriptions', to: 'customer_subscriptions#index'
        post '/:id/customer_tea_reviews', to: 'customer_tea_reviews#create'
      end
    end
  end
end
