class HomeController < ApplicationController 
    def index 
        # @profile= Profile.find_by(username:sessions[:profile_id])
         if session[:profile_id] 
             @profile = Profile.find(session[:profile_id]) 
           end
      
    end
end
