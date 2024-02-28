 def create  
              begin
                 @shopuser=Shop.find_by(s_username:params[:shop][:s_username])                        redirectn_to new_shop_path(session[:username])
                 puts @shopuser 
                 if @shopuser==nil
                  response=Cloudinary::Uploader.upload(params[:shop][:image])
                  puts response
                   if response 
                        @profile=Profile.find_by(username:params[:username])
                        if @profile 
                           @shop=@profile.shops.new(shop_params)
                            @shop.image=response['secure_url']
                             if @shop.save 
                                 ShopMailer.shop_create_message(@profile) 
                                 flash[:success]="Shop Create Successfully"
                                 redirect_to dashboard_path(params[:username])
                             else 
                                  flash[:error]="Shop Not Create"
                                  redirect_to new_shop_path(params[:username])
                             end
                        else
                            flash[:error]="Profile not found"
                            redirect_to dashboard_path(params[:username])
                        end
                     else      
                        flash[:error]= "Image not save in cloudinary"
                        redirect_to new_shop_path(params[:username])
                     end
                  else  
                        flash[:error]="please enter different username"   
                  end
                rescue => e 
                flash[:error]="#{e.message}"
              end 

           end
         
           private 
             def shop_params 
                 para