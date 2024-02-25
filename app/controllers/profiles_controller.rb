require 'net/http'
require 'json'
class ProfilesController < ApplicationController  
  before_action :api_state, only: [:new]
  before_action :generate_otp, :expiry_time, only: [:create]
  before_action :expiry_time, :generate_otp, only: [:sendotp]

  def new 
    @state = api_state()
    puts @state
    @profile = Profile.new
    # In your controller or wherever you want to trigger the email sending

  end

  # Generate unique OTP 
  def generate_otp
    puts "generate otp running"
    return (((rand*8999)+1000).ceil).to_s
  end

  # Create Expiry Time with OTP
  def expiry_time 
    puts "expire date"

    return  (Time.now) + 60*5
  end

  def sendotp(email)
    @otp= generate_otp()
    @expiry_at=expiry_time()

  puts "#{email} #{@otp} #{@expiry_at}"
    @otpdata = Otp.new(email: email, otp: @otp, expiry_at: @expiry_at)
    UserMailer.welcome_email(@otpdata).deliver_now
    if @otpdata.save
  
      redirect_to verificationOtp_path   
    else   
      flash[:error] = "Otp send failed"
      redirect_to new_profile_path  
    end
  end

  # SEND OTP into database and create instance of profile
  def create 
    begin  
      @profile = Profile.find_by(email: params[:profile][:email], verified: true)
      if @profile
        flash[:error] = "Email already exists"
        redirect_to new_profile_path

      elsif (Profile.find_by(email: params[:profile][:email], verified: false))
        session[:email] = params[:profile][:email]
        sendotp(session[:email])                           
      else  
        @profile = Profile.new(profile_params)
        @profile.verified = false 
        if @profile.save
          session[:email] = params[:profile][:email]
          sendotp(session[:email])
        end
      end
    rescue => e
      flash[:error] = "An error occurred: #{e.message}"
      redirect_to profiles_path
    end
  end


  def resend_otp
    begin
      @profile = Profile.find_by(email: session[:email])
      if @profile && !@profile.verified
        flash[:success]="Otp sent successfully"
        sendotp(session[:email])
      else
        flash[:error] = "Profile not found"
      end
    rescue => e
      flash[:error] = "An error occurred: #{e.message}"
    end
  end
  






  def verifyotp
  end

  def verify
    begin 
      @otprecord = Otp.where(email: session[:email]).last
      @userotp="#{params[:otp1]}#{params[:otp2]}#{params[:otp3]}#{params[:otp4]}"
      if @otprecord.otp ==@userotp
        @upprofile = Profile.find_by(email: session[:email])
        if @upprofile.update_column(:verified, true)
          flash[:success] = "Otp verification successful"
          redirect_to root_path
        end       
      else 
        flash[:error] = "Otp verification failed"
        redirect_to verificationOtp_path
      end   
    rescue => e 
      flash[:error] = e.message
      redirect_to verificationOtp_path
    end        
  end
           
  private

  def profile_params
    params.require(:profile).permit(:username, :firstname, :lastname, :user, :gender, :dob, 
    :email, :password, :state, :city, :address, :phonenumber, :image)
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
  
