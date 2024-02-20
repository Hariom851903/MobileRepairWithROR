class SessionsController < ApplicationController 
    def new
    end
        def create
            @profile = Profile.find_by(email: params[:email])
                
            puts @profile 
            if @profile && @profile.authenticate(params[:password])
              # Log in the user
              session[:profile_id] = @profile.id
              session[:username]=@profile.username
              flash[:success]='Logged in successfullylkh'
              redirect_to dashboard_path(@profile.username)
            else
              flash[:error] = 'Invalid email or password'
              redirect_to  logined_path
            end
        end
        def destroy 
            if session[:profile_id]
                session[:profile_id]=nil
                session[:username]=nil
                flash[:success]= 'Logged out!'   
                redirect_to root_path
            end    
        end
end
