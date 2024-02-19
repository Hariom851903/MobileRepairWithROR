class DashboardController < ApplicationController 
                
           def index 
            @username=params[:username]
            @profile=Profile.find_by(username: params[:username])

           end
end