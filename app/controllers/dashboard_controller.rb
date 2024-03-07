class DashboardController < ApplicationController 
                
        def index 
            @username=params[:username]
            @profile=Profile.find_by(username: params[:username])
            if params[:s_username].present?

           @orderdetails=s = Order.joins([mobile: [:profile,
           { mobile_problem_lists: :problem_list }]],:shop)
            .select("orders.id  As order_id ", "problem_lists.*", "profiles.*", "mobiles.*")
            .where("shops.s_username = ? And orders.status=?", "Jai@12","requested")
            .order("orders.created_at ASC")

    

            end
        end

end