class SessionsController < ApplicationController 
    def new
    end
  
    def create
      if !(session[:username].nil?)
        # Check if there's no session username (meaning no profile is logged in)
        # Login for Profile
          @shop = Shop.find_by(s_username: params[:s_username])
        
          if @shop && @shop.password_digest==params[:password_digest]
          session[:s_username] = @shop.s_username  
          flash[:success] = "Shop Login Successfull"
               redirect_to dashboardshop_path(session[:username],session[:s_username])
        else
          
          flash[:error] = "Shop Login Failed"
          redirect_to '/login'
        end
    else
        # Login for Shop
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
        
     # Always redirect somewhere after the shop login attempt
      end
    end
  
    def destroy 
      if !(session[:s_username].nil?) && !(session[:username].nil?)
        session[:s_username]= nil  
        flash[:success] = 'Logged out!'   
        redirect_to dashboard_path(session[:username])
      else   
        session[:profile_id] = nil
        session[:username] = nil
        session[:email] = nil  
        session[:s_username]=nil
        flash[:success] = 'Logged out!'   
        redirect_to root_path     
     end
    end
  end
  