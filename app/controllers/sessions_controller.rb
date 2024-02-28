class SessionsController < ApplicationController 
    def new
    end
        def create
            if params[:username]==nil 
                #Login For Profile
                @profile = Profile.find_by(email: params[:email],verified: true)
                puts @profile 
                if @profile && @profile.authenticate(params[:password])
              
                    session[:profile_id] = @profile.id
                    session[:username]=@profile.username
                    session[:email]=@profile.email
                    flash[:success]='Logged in successfullylkh'
                    redirect_to dashboard_path(@profile.username)
                else
                    flash[:error] = 'Invalid email or password'
                    redirect_to  logined_path
               end
            else 
                 #Login For Shop
               @shop= Shop.find_by(s_username:params[:s_username])
               if @shop && @shop.authenticate(params[:password])
                       session[:s_username]=@shop.s_username  
                       flash[:success]="Shop Login Successfully"             
               else
                flash[:error]="Shop Login Faild" 
               end          
            end                             

        end
        def destroy 
            if session[:profile_id]
                session[:profile_id]=nil
                session[:username]=nil
                session[:email]=nil
                flash[:success]= 'Logged out!'   
                redirect_to root_path
            end    
        end
end
