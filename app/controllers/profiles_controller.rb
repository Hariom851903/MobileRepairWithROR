require 'net/http'
require 'json'
class ProfilesController < ApplicationController  
  before_action :api_state, only: [:new]
  before_action :generate_otp, only: [:create]
  before_action :expiry_time, only: [:create]
    def new 
      @state= api_state()
      puts @state
      @profile = Profile.new

    end

       # Generate unique  Otp 
      def generate_otp
            puts "generate otp runing"
        @otp= (((rand*8999)+1000).ceil).to_s
      end
    # Craete Expiry Time with OTP
      def expiry_time 
        puts "expire date"
         @expiry_at=(Time.now)+60*5
     end

   #SEND OTP into database and create instance of profile
    def create 

      begin  
        # puts "otp::#{@otp}" 
        # puts "expiry_date::#{@expiry_at}"
      
        @profile = Profile.find_by(email: params[:profile][:email])
        if @profile
          flash[:error] = "Email already exists"
          redirect_to profiles_path
        else  
          @profile = Profile.new(profile_params)
          if @profile.save
               redirect_to logined_path

          # if @profile.save
            # flash[:success] = "Profile created successfully"
            
            # @otpdata=Otp.new(email:params[:profile][:email], 
            # otp:@otp, expiry_at: @expiry_at)
            # if(@otpdata.save)
              # redirect_to verificationOtp_path
                
            # else           
                #  flash[:error]= "Otp not generate please valid phone_number"
                #  redirect_to root_path
            # end
          else   
                 flash[:error]="Signup faild"
                 redirect_to profiles_path  
          end
        end
      rescue => e
        flash[:error] = "An error occurred: #{e.message}"
        redirect_to profiles_path
      end
  end
    #OTP verification
    # def verifyotp
    #         puts "#{session[:profile]}fdhjb"
    # end

    # def verify
    #   @profile= session[:profile]
    #   puts "#{@profile}kjgdavj"
    #   puts "email::#{@profile["email"]}"
    #   begin 
    #       @otprecord= Otp.find_by(email: session[:profile]["email"])
    #       puts "otp::database#{@otprecord.otp}"
    #       puts "otp1::#{params[:otp]}"
    #       if (@otprecord.otp).eql?(params[:otp])
    #         puts "define"
    #          if @profile.save
    #               puts "hariom" 
    #               flash[:success]="Profile Create Successfully"
    #               redirect_to root_path
    #          else 
    #                  flash[:error]="Profile feild"
    #                  redirect_to root_path
    #          end
    #       else 
    #         flash[:error]="Otp verification failed"
    #       end   
    #   rescue =>e 
    #       flash[:error]=e.message
    #           redirect_to verificationOtp_path
              
    #   end        
    # end
           
    private
  
    def profile_params
        params.require(:profile)
        .permit(:username,:firstname, :lastname,
        :user,:gender, :dob, :email, :password,:state,:city,:address,:phonenumber,:image)
       end
    def api_state
        url = URI("https://cdn-api.co-vin.in/api/v2/admin/location/states") # Replace this with the API endpoint URL
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true if url.scheme == 'https' # Enable SSL if the API endpoint uses HTTPS
        request = Net::HTTP::Get.new(url)
        response = http.request(request)
      
        if response.code == '200' # Check if the response is successful
          data = JSON.parse(response.body) # Parse the JSON response
          states = data["states"] # Access the states data from the parsed JSON
          return states
        else
          puts "Error: #{response.code} - #{response.message}" # Print the error message
          return nil
        end
      end     
  end
  
