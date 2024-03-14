class ShopsController < ApplicationController  
  def new 
    @shop = Shop.new
  end

  def create
    @shopuser = Shop.find_by(s_username: params[:shop][:s_username])

    if @shopuser.nil?
      begin
        @response = Cloudinary::Uploader.upload(params[:shop][:image])
        @profile = Profile.find_by(username: params[:username])

        if @response && @profile
          @shop = @profile.shops.new(shop_params)
          @shop.image = @response['secure_url']
          
          if @shop.save
            ShopMailer.shop_email_message(@profile).deliver_now
            flash[:success] = "Shop created successfully"
            redirect_to dashboard_path(params[:username])
          else
            flash[:error] = "Shop not created"
            redirect_to new_shop_path(params[:username])
          end
        else
          flash[:error] = "Profile not found or image not saved in Cloudinary"
          redirect_to dashboard_path(params[:username])
        end
      rescue => e
        flash[:error] = e.message
        redirect_to new_shop_path(params[:username])
      end
    else
      flash[:error] = "Please enter a different username"
      redirect_to new_shop_path(params[:username])
    end
  end
    
  
 
  
  private 
  def shop_params 
    params.require(:shop).permit(:s_name, :s_username, :password_digest, :state, :district, :city, :address)
  end
end
