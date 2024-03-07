class MobilesController < ApplicationController
    def new
      @profile= Profile.find_by(id:session[:profile_id])
      @mobile = Mobile.new
    end
    def index 
      @profile= Profile.find_by(id:session[:profile_id])
      @mobiles= Mobile.where(profile_id:session[:profile_id])
    if !(params[:city].nil?)
      puts params[:city]
      @shops=Shop.where(city:params[:city])
    end   
    end
  
    def create
      begin
        @profile = Profile.find_by(username: params[:username])
        puts @profile
        if @profile
          @mobile = @profile.mobiles.new(imei: params[:mobile][:imei], 
          brand: params[:mobile][:brand], model: params[:mobile][:model],
          description: params[:mobile][:description] )
          
          if @mobile.save
            @problem_list = ProblemList.find_by(id: params[:problem_list_id])
            
            if @problem_list
              # Create a new MobileProblem record to associate the Mobile with the ProblemList
              @m_problem = @mobile.mobile_problem_lists.new(problem_list_id:@problem_list.id)
              
              if @m_problem.save
                flash[:success] = "Mobile and Problem association created successfully"
                redirect_to dashboard_path(username: params[:username])
              else
                flash[:error] = "Mobile problem not saved: #{@m_problem.errors}"
                redirect_to new_mobile_path(username: params[:username])
              end
            else
              flash[:error] = "Selected problem list does not exist"
              redirect_to new_mobile_path(username: params[:username])
            end
          else
            flash[:error] = "Failed to save mobile: "
            @mobile.errors.full_messages.each do |msg|
              flash[:error] += "#{msg}. "
            end
            redirect_to new_mobile_path(username: params[:username])
          end
        else
          flash[:error] = "Profile not found"
          redirect_to new_mobile_path(username: params[:username])
        end
      rescue => e
        flash[:error] = "Error occurred: #{e.message}"
        redirect_to new_mobile_path(username: params[:username])
      end
    end
       
    
    def search
      @shop= Shop.where(city:params[:city])
    end
       
    
      
      private
      
      def mobile_params
        params.require(:mobile).permit(:imei, :brand, :model)
      end
      
  end
  
#   @mobile = @profile.mobiles.new()