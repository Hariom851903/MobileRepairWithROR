
class OtpsController < ApplicationController 
    
           def new
           end
          def create 

            begin
                @otp= Otp.new(email:params[:profile][:email])
                if @otp.save 
                   render :new
                else 
                     flash[:error]="Otp not generate"
                end
            rescue => e
                      flash[:error]=e.message
            end  
          end     

         
          
          def profile_params
            params.require(:profile)
            .permit(:username,:firstname, :lastname,
            :user,:gender, :dob, :email, :password,:state,:city,:address,
            :phonenumber,:image)
           end
end