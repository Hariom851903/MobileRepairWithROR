Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create' , as: 'logined'
  get 'dashboard/:username/login', to: 'sessions#new', as: 'loginshop'
  get '/logout', to: 'sessions#destroy', as: 'logout'  
  get   '/dashboard/:username',to: 'dashboard#index',as: 'dashboard'
   get '/dashboard/:username/shop/:s_username', to: 'dashboard#index', as: 'dashboardshop'
  root "home#index"
  get '/verification_otp', to: 'profiles#verifyotp', as: 'verificationOtp'
  post '/verify_otp',to: 'profiles#verify', as: 'verifiedotp' 
  post 'resend_otp', to: 'profiles#resend_otp'

       resources :otps
      resources :profiles
      scope 'dashboard/:username' do
      # Ex:- scope :active, -> {where(:active => true)}
      resources :mobiles
      end    
        scope 'dashboard/:username' do 
          resources :shops
      end
      # Add routes for customer dashboard here


end
