require 'net/http'
require 'json'
class ProfilesController < ApplicationController  
  before_action :api_state, only: [:new]
    def new 
      @state= api_state()
      puts @state
      @profile = Profile.new

    end
  
    def create 
      begin
        @profile = Profile.find_by(email: params[:profile][:email])
        if @profile
          flash[:error] = "Email already exists"
          redirect_to profiles_path
        else  
          @profile = Profile.new(profile_params)
        
          if @profile.save
            flash[:success] = "Profile created successfully"
           
            redirect_to root_path
          else
            flash[:error] = "Failed to create profile. Please check the form for errors."
            redirect_to profiles_path
          end
        end
      rescue => e
        flash[:error] = "An error occurred: #{e.message}"
        redirect_to profiles_path
      end
    end 
    
           
    private
  
    def profile_params
        params.require(:profile)
        .permit(:username,:firstname, :lastname,
        :user,:gender, :dob, :email, :password,:state,:city,:address,:phonenumber)
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
  
