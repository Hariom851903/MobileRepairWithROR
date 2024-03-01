class OrdersController < ApplicationController 
             
       def new 
           @order=Order.new
           @profile=Profile.find_by(username:session[:username])
           @mobiles=@profile.mobiles 
       end
       
        def create 
        end


end

