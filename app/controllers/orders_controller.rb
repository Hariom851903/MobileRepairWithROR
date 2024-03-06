class OrdersController < ApplicationController 
             
       def new 
           @order=Order.new
           @profile=Profile.find_by(username:session[:username])
           @mobiles=@profile.mobiles 
       end
       

       def RandomTrackNumber
        @tracking_id=[] 
        (1..2).each do |i|
             @tracking_id.push(((rand*9).ceil).to_s)
            (0...1).each do |i|
             @tracking_id.push((((rand*26)+65).ceil).chr)
             @tracking_id.push(((rand*9).ceil).to_s)
             @tracking_id.push(((rand*26+97).ceil).chr)
            end
         @tracking_id.push(((rand*9).ceil).to_s)
        end
        return @tracking_id.join('')
      end

        def create 
            begin
                @mobile=Mobile.find_by(imei:params[:order][:imei])
                @previous_order=@mobile.orders.where(status:['requested','reject','complete'])
            
                if @previous_order.length==0 
                    @order=@mobile.orders.create(status:'requested',shop_id:params[:shop_id])
                    if @order.save 
                        @tracknumber=RandomTrackNumber()
                        @trackorder=@order.build_track_order(tracking_id:@tracknumber) 
                        if @trackorder.save 
                            @user=Profile.find_by(id:session[:profile_id])
                            OrderMailer.order_mail(@trackorder,@mobile,@user).deliver_now
                            flash[:success]="Your Order have created and check status" 
                            redirect_to  neworder_path(session[:username],params[:shop_id])
                        else 
                            flash[:error]="Your Order save but not generate Tracking_id"
                            redirect_to  neworder_path(session[:username],params[:shop_id])
                        end    
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
        def statusupdate 
         @update= Order.find_by(id:) update_columns(status:params[:status])
         if @update 
             redirect_to dashboardshop(params[:username],params[:s_username])
         end
        end
 
end

