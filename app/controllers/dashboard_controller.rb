class DashboardController < ApplicationController 
                
        def index 
            @username=params[:username]
            @profile=Profile.find_by(username: params[:username])
            if params[:s_username].present?

           @orderdetails=s = Shop.joins(orders: [mobile: [:profile, { mobile_problem_lists: :problem_list }]])
           .select("orders.id", "shops.*", "problem_lists.*", "profiles.*", "mobiles.*")
           .where("shops.s_username = ? And orders.status=?", "#{params[:s_username]}","requested")
           .order("orders.created_at ASC")
    

            end
        end

end