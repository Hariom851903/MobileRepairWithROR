class SessionsController < ApplicationController 
    def new
    end
  
    def create
      if session[:username].nil? # Check if there's no session username (meaning no profile is logged in)
        # Login for Profile
        @profile = Profile.find_by(email: params[:email], verified: true)
        
        if @profile && @profile.authenticate(params[:password])
          session[:profile_id] = @profile.id
          session[:username] = @profile.username
          session[:email] = @profile.email
          flash[:success] = 'Logged in successfully'
          redirect_to dashboard_path(@profile.username)
        else
          flash[:error] = 'Invalid email or password'
          redirect_to logined_path
        end
      else
        # Login for Shop
        @shop = Shop.find_by(s_username: params[:s_username])
        
        if @shop && @shop.password_digest==params[:password_digest]
          session[:s_username] = @shop.s_username  
          flash[:success] = "Shop Login Successfull"
        else
          flash[:error] = "Shop Login Failed"
        end
        redirect_to root_path # Always redirect somewhere after the shop login attempt
      end
    end
  
    def destroy 
      if session[:profile_id]
        session[:profile_id] = nil
        session[:username] = nil
        session[:email] = nil
        flash[:success] = 'Logged out!'   
        redirect_to root_path
      end    
    end
  end
  