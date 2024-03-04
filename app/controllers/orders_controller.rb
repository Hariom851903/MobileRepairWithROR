class OrdersController < ApplicationController 
             
       def new 
           @order=Order.new
           @profile=Profile.find_by(username:session[:username])
           @mobiles=@profile.mobiles 
       end
       

       def RandomTrackNumber  
              

       end

        def create 
            begin
                @mobile=Mobile.find_by(imei:params[:order][:imei])
                @previous_order=@mobile.orders.where(status:['requested','reject','complete'])
            
                if @previous_order.length==0 
                    @order=@mobile.orders.create(status:'requested',shop_id:params[:shop_id])
                    if @order.save 
                        flash[:success]="Your Order have created and retailer response your mail" 
                        redirect_to  neworder_path(session[:username],params[:shop_id])  
                    else  
                         flash[:error]="Your order have not created some problem"
                         redirect_to neworder_path(session[:username],params[:shop_id])
                    end     
                else  
                    flash[:error]="This Order alread exit"
                    redirect_to neworder_path(session[:username],params[:shop_id])
                end        
            rescue=> e 
                flash[:error]="#{e.message}"
                redirect_to neworder_path(session[:username],params[:shop_id])
            end
        end
    

end

